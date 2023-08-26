with cte_remove_duplicate as (
	select [Distinguished Name], [Alarm Time], [Cancel Time], [Supplementary Information], ROW_NUMBER() over(partition by [Distinguished Name], [Alarm Time], [Cancel Time], [Supplementary Information] order by [Supplementary Information])[#rank]
	from
		[dbo].[CHECK_AlarmHistory]
)

delete from cte_remove_duplicate
where #rank > 1;