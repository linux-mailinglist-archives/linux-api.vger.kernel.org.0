Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633D06D58D
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 22:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfGRUCa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 16:02:30 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:42618
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728054AbfGRUC3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563480146; bh=3XHTbPxjlqR349Jd+AgcWTpbkDyjsLLCIrnOdyDgJOM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=JAK2ECUACLGw/Xnu1H6ef0hOiN4LDsbzWJM2RY00kIfaTTICC9QaL95c4QXDCiOVFSpnX9qd1+wNNTcss12f736NXhboJgTnUdz6mTwY/jzpICmtzPZz4WvymiiRIE6yk29/5GNN88+Jzs8u3+XDd6lIH5pPpITOyTkP2wIPcDtrV0NSIBzJtSOxGdP4ss8g/jEp2ky8XVozUyiJ0TonRVxEnp1ACmHVb4BCYqSJJe93EHdZ3zH++mwoVkbzfv5NDClu213f41SkCPCs7VKNNmPMJUw4EGSO9Hda+x9qyQLDqjenbf/ISqtbGPCPHMLTe974AZ5l8jO6X3gRbUvXqA==
X-YMail-OSG: Iv1PpJ4VM1kQ1Hg057p7eSjP6UrHTo7bljhRbYFApBgLFFCBRYP.6HyNv0hBI_I
 qumpkkSxYqMA80ezwrGQK37PMpQVVcH3pVet3CwB6exbGkeqo5bvyeYs_H12JAub67X4w8x96SzX
 DamSoYp3kxsfkFuC_rOsAfjBxFEaj7cQoDkO5sFrhkaO.CebC.t5ZKhPdxc74caLahTzZkKZXN2I
 DfQ8TSy00AVhZOdwTU1XBeeVBbR1_YVuklW6jne6E__vFQF4QwslxFQCsw272AAN.C5t0KWghheJ
 m1ZEh9J_DWyFQK7MooxZEenOs_3xwecut0GXtc1bHVrxi8I3_.NWRjgUFbzeZBW3TBMg24eXIgmC
 grhx1x244B4TYtaRJp3PEasgOoboWnoyJMqVG7oBYwPQ2Td78jQkVmMfc41nmQ.K.Y8gCuP8.SGe
 a6qrGHI5RelMoD1ZGRy.YEDPxADGhjvdOf1xR.kZJWPzkPUoQvAG2XwFKNIzkxnLD_8oSHiZ4LJY
 OWwKadnTiGWxiyYPNxg90LslakdZraCNuC1rGUAnirFCevTTdTr3uCZiapyf7S_kqXxw1IGRNo.P
 eJ2tRcTl1V.Rltw7y.pFpPSrNEzY8ffschLGpHW5I_pgu_JC3HyykgNgesxW0Xvd0qehS9jouhc1
 CjX1V0axzfvbH3XLfHBajtPNCE_4vjUsL2hXZMgnXr_hGA8tRkmWPZQhe3CjVndRsExgfw2ZuR7l
 Yx5MFqAdGdlBV4XTdZ1zlEttkwobBI8KqaN0a8YtU6bWwVfOwQBLFNnahZeNPCl98ZZdBEoMIe0r
 ytBp1fFopMaTW_Xe889irYixVHS6NV7IA2rIS.cGBIDKSe745TjtfEmj_s7PFOBnG2iW5WC.nKOo
 vOR1HmjgGo3ZKGQ7JS86Xryc7RIyijo1S9vhi.KEfVonkmhfCD7SUna__AGXVY4_9BUvS1Wn5wVm
 JVzx3SOzk4azjjRpGlJzgAxcgD0iBctl_5n0aKyV_wFjEW0pxckbuZZIbIELq0r_FsqDsLDopJ7.
 g6vyS2mByCHyMK2MawOX_PzIZE_ANuhJ9G2.pWoU_P8B3mR0NsgWgrQcDavZLBuWMTyM1Uh.HqU7
 .olbk3w50dvGwD_FPbzhY45nDifjcfQEovl2FG6e2VSocU2Fg0JUGDUHAW9ZwduKQv8WIoJvUu4d
 tg_TtroGTarrmabiuHOR6IT_kMcetNDUUc5A2JVrWe2DykbhjDlduqA8GuIwS9BUOrfVFNXFROnE
 6rmc9jz.7iXhfxeRM7_ZkhcZXp4MKf5SICOU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2019 20:02:26 +0000
Received: by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b31b3a1df9e8c83c69c41710a3e50fc9;
          Thu, 18 Jul 2019 20:02:26 +0000 (UTC)
Subject: Re: [PATCH V36 01/29] security: Support early LSMs
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20190718194415.108476-1-matthewgarrett@google.com>
 <20190718194415.108476-2-matthewgarrett@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9312127b-f98a-b10b-1059-8a1380cc0047@schaufler-ca.com>
Date:   Thu, 18 Jul 2019 13:02:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718194415.108476-2-matthewgarrett@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/18/2019 12:43 PM, Matthew Garrett wrote:
> The lockdown module is intended to allow for kernels to be locked down
> early in boot - sufficiently early that we don't have the ability to
> kmalloc() yet. Add support for early initialisation of some LSMs, and
> then add them to the list of names when we do full initialisation later.
> Early LSMs are initialised in link order and cannot be overridden via
> boot parameters, and cannot make use of kmalloc() (since the allocator
> isn't initialised yet).
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>


Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/asm-generic/vmlinux.lds.h |  8 ++++-
>  include/linux/lsm_hooks.h         |  6 ++++
>  include/linux/security.h          |  1 +
>  init/main.c                       |  1 +
>  security/security.c               | 50 ++++++++++++++++++++++++++-----
>  5 files changed, 57 insertions(+), 9 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index ca42182992a5..6cc6174a2a4c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -215,8 +215,13 @@
>  			__start_lsm_info = .;				\
>  			KEEP(*(.lsm_info.init))				\
>  			__end_lsm_info = .;
> +#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
> +			__start_early_lsm_info = .;			\
> +			KEEP(*(.early_lsm_info.init))			\
> +			__end_early_lsm_info = .;
>  #else
>  #define LSM_TABLE()
> +#define EARLY_LSM_TABLE()
>  #endif
>  
>  #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
> @@ -616,7 +621,8 @@
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
>  	EARLYCON_TABLE()						\
> -	LSM_TABLE()
> +	LSM_TABLE()							\
> +	EARLY_LSM_TABLE()
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index df1318d85f7d..aebb0e032072 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2104,12 +2104,18 @@ struct lsm_info {
>  };
>  
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
>  #define DEFINE_LSM(lsm)							\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(.lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))
>  
> +#define DEFINE_EARLY_LSM(lsm)						\
> +	static struct lsm_info __early_lsm_##lsm			\
> +		__used __section(.early_lsm_info.init)			\
> +		__aligned(sizeof(unsigned long))
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  /*
>   * Assuring the safety of deleting a security module is up to
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f7441abbf42..66a2fcbe6ab0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -195,6 +195,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>  
>  /* prototypes */
>  extern int security_init(void);
> +extern int early_security_init(void);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(struct task_struct *mgr);
> diff --git a/init/main.c b/init/main.c
> index ff5803b0841c..0fefca3fd43c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -593,6 +593,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	boot_cpu_init();
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
> +	early_security_init();
>  	setup_arch(&command_line);
>  	mm_init_cpumask(&init_mm);
>  	setup_command_line(command_line);
> diff --git a/security/security.c b/security/security.c
> index 250ee2d76406..90f1e291c800 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -33,6 +33,7 @@
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> @@ -277,6 +278,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> +static int lsm_append(const char *new, char **result);
> +
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> @@ -323,6 +326,26 @@ static void __init ordered_lsm_init(void)
>  	kfree(ordered_lsms);
>  }
>  
> +int __init early_security_init(void)
> +{
> +	int i;
> +	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct lsm_info *lsm;
> +
> +	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> +	     i++)
> +		INIT_HLIST_HEAD(&list[i]);
> +
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (!lsm->enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +		prepare_lsm(lsm);
> +		initialize_lsm(lsm);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -330,14 +353,18 @@ static void __init ordered_lsm_init(void)
>   */
>  int __init security_init(void)
>  {
> -	int i;
> -	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct lsm_info *lsm;
>  
>  	pr_info("Security Framework initializing\n");
>  
> -	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> -	     i++)
> -		INIT_HLIST_HEAD(&list[i]);
> +	/*
> +	 * Append the names of the early LSM modules now that kmalloc() is
> +	 * available
> +	 */
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (lsm->enabled)
> +			lsm_append(lsm->name, &lsm_names);
> +	}
>  
>  	/* Load LSMs in specified order. */
>  	ordered_lsm_init();
> @@ -384,7 +411,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>  	return !strcmp(last, lsm);
>  }
>  
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>  	char *cp;
>  
> @@ -422,8 +449,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsm = lsm;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> -		panic("%s - Cannot get early memory.\n", __func__);
> +
> +	/*
> +	 * Don't try to append during early_security_init(), we'll come back
> +	 * and fix this up afterwards.
> +	 */
> +	if (slab_is_available()) {
> +		if (lsm_append(lsm, &lsm_names) < 0)
> +			panic("%s - Cannot get early memory.\n", __func__);
> +	}
>  }
>  
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data)
