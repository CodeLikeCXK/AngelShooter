class AAngelPlayerControllerLegacy : APlayerController
{
  AActor LastActor;
  AActor ThisActor;

  UPROPERTY(DefaultComponent)
  UInputComponent InputComponent;
  default bShowMouseCursor = true;
  default DefaultMouseCursor = EMouseCursor::Default;  



  UFUNCTION(BlueprintOverride)
  void ConstructionScript()
  {
    //InputComponent = UInputComponent::Get(this);
    //PushInputComponent(InputComponent);
      //setup input   
  } 

  UFUNCTION(BlueprintOverride)
  void BeginPlay()
  {

  }

  UFUNCTION(BlueprintOverride)
  void Tick(float DeltaTime)
  {     
     CursorTrace();
  }

  UFUNCTION()
  void CursorTrace()
  {
      FHitResult CursorHit;
      GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, CursorHit);
      if(CursorHit.bBlockingHit) return;
      LastActor = ThisActor;
      ThisActor = CursorHit.GetActor();
      UAngelEnemyComponent AngelEnemyComponent;
      UAngelEnemyComponent ThisEnemyComponent =  Cast<UAngelEnemyComponent>(ThisActor.GetComponentByClass(AngelEnemyComponent));
      UAngelEnemyComponent LastEnemyComponent =  Cast<UAngelEnemyComponent>(ThisActor.GetComponentByClass(AngelEnemyComponent));

      //line trance from cursor

      if(LastActor == nullptr)
      {
        if (ThisActor != nullptr && ThisEnemyComponent != nullptr)
        {
          Print("Hello world");
          ThisEnemyComponent.HighLightActor();
        }
        else
        {
          
        }
      }
      else
      {
        if(ThisActor == nullptr && LastEnemyComponent != nullptr)
        {
          LastEnemyComponent.UnHighLightActor();
        }
        else
        {
          if(LastActor != ThisActor)
          {
           LastEnemyComponent.UnHighLightActor();
           ThisEnemyComponent.HighLightActor();
          }
          else
          {
            
          }
        }
      }


  }
}
