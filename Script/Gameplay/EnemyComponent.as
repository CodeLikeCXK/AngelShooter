class UAngelEnemyComponent : UActorComponent
{
    UPROPERTY(BlueprintReadOnly)
    bool bHighLighted = false;
    
    //trying to move highlight and unhighlight actor to character base
   //not sure if it's difference between AS and CPP

    UFUNCTION()
    void HighLightActor()
    {
        bHighLighted = true;
    }

    UFUNCTION()
    void UnHighLightActor()
    {
        bHighLighted = false;
    }

  
}

