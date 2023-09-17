class AAngelEnemyControllerBaseBT : AAIController
{
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UBehaviorTree BehaviorTree;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        RunBehaviorTree(BehaviorTree);
    }
}