Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2528F6D591
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390937AbfGRUDs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 16:03:48 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:40787
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391319AbfGRUDr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563480225; bh=KBAXOHJz2fca4O0taf9YqR6+KnsO9p1ZOEsavfERqQ4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=o38nSgKi/pES+e1k7HUV9IMe537vZXdCLfaurH4/lDDrTTJujd/ZOs4dRRz7fy75SfZj9mIDEIXkwP8Q98otqdINosepRShCc2Gr7P/GV2zrldvO+hQJWgplQ9IJsBgizYoiD4jNPhv/X7itSak381AFuBjiulIiOKRWqINkSVpL5tEDY4xsxRgaQVQK3nRV5Ih79Tb+NFbiZoXKFmfFlimG9Qt4r1GTfOFHcWH2a8iDMFZqiktwob953SU0v2rvPhf/0kWLcKl/HpUcS18Xzhcq5ES1hHdQ9IjwWIxhPq2jMrdcphj/5vifZc6OyTe48T5VKf2sH6VHxTDTpWk5NQ==
X-YMail-OSG: Sgp9VgEVM1k7rBstz.tusOALADJTv1y7Vwlew8jnJ60Btb.Ec9l3jo5LT3E0ZiO
 gz8kIUZp7cr7biHqwNv.tOiV645GXCf9YaLieDD3PXI4HUfiIEYqXHba5WzTyCVyjTSX5j.GBKbX
 8wH4fklNN_U7X6HeoC39MD5xtMfeAt37HE8WfVeKsHfTh3g2PvI6dkYLy.IEMm8Oy7QDgMfeCFPy
 KCYoYqDgA2ZYwmSFBwEvWRqfwRGwU0_k0n4Iff3_Oz4lzrRFk817mYcCTJ09iJuafNxazOjDYeFJ
 ibS94OukMr20NKQ2vGJmox3m0VbB3cp_Z.VqzeeAcr0RkZd.leEVefWlC4gjUqMAGZYFtHJMMz5l
 Phj03eQ2jBN0TpXQDP8h_jI_HsNRqZTw0leZCDGlZkeGM49Tz49S4TJg79MUBVZ2qBiMoNG7d3W0
 eRjroAmcX3.AvvufQRz.s1TOZpmXKj8C47g7Ofcv5S_OXUUHpDVwDZkD7dWSb6nS5Q5b8MIZsFi3
 v1UshQZ_TuO1ECX3bcnQ8ESTOmMxpjtiKqNxk_FnJ3HM_kEn_GoRR_kD9oSrDR.lPkcjPoakpmRH
 gkVQ7NrAwaKpb2uM1RKynFf6QaoGOD4T5_H7427BpBc83xpzXCSdcSsodoniSWC061oqKfdITtOe
 t9CRyG_I9OvOsdBhRwHA6F8WeDIOsIJ39mOwFSeoShS2m06qGJy4RZan..jEgTzBbj0pd1fY60UG
 .XLmD.dX2.mffH31FZng7Zlwk3PojlVxUdLXcKEYWl09br1dNwVymid5J6tWA71s7M2Mf6C03kEk
 PHxoJrvkdDwJMVxRYYNSVBxq2dVShK5whHgti5gp.T7KHwZ6Mq5hOOAgoIzwP1EVlt7i62YJHKNw
 2EVpogg71sWSN2mIDJ8EsWLDh22DUlYhwV5l1zZEIFCM5EA0N9O_3REwUJjbJuZ9HQ5AUcUFmd.h
 oVmVi2PewKVOn6bcZFgne3DDd4V4TBswWQ2D1wbnoEdhAC_6EPqP62bbClIPOfsha6NfNgnaLpIk
 AuxQk1Qa2W.cWtJ6ad5dinqluH.9hXPySKun6x8u0a.PAjOQFOZb4U7F_JKafa7o8.Ck8OK.V1Yb
 clNkBIEzTWMzEZxnBTFOn5Xav6ApU7U3C6hg.rXt.mxdGUDiaQVfESwlKgKd8eIRC0ScaQLrWnbT
 DmzIahbWhTp8ENZnR9fRGYc2oDuc7L0BvW3oHLbk_nKXLq46y3AVfGs8itLHJzn6S.gxXowS.Bg3
 ITvLdXqdbrXWDBj3EddubGNW9abW3iYFvG1_P
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2019 20:03:45 +0000
Received: by smtp414.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c1282634ca533d77411ddfb04f3721a2;
          Thu, 18 Jul 2019 20:03:41 +0000 (UTC)
Subject: Re: [PATCH V36 02/29] security: Add a "locked down" LSM hook
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20190718194415.108476-1-matthewgarrett@google.com>
 <20190718194415.108476-3-matthewgarrett@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <b2d853d9-4968-d0ea-9d9b-cba2b9957394@schaufler-ca.com>
Date:   Thu, 18 Jul 2019 13:03:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718194415.108476-3-matthewgarrett@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/18/2019 12:43 PM, Matthew Garrett wrote:
> Add a mechanism to allow LSMs to make a policy decision around whether
> kernel functionality that would allow tampering with or examining the
> runtime state of the kernel should be permitted.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h |  2 ++
>  include/linux/security.h  | 32 ++++++++++++++++++++++++++++++++
>  security/security.c       |  6 ++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index aebb0e032072..29c22cf40113 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1807,6 +1807,7 @@ union security_list_options {
>  	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
>  	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
>  #endif /* CONFIG_BPF_SYSCALL */
> +	int (*locked_down)(enum lockdown_reason what);
>  };
>  
>  struct security_hook_heads {
> @@ -2046,6 +2047,7 @@ struct security_hook_heads {
>  	struct hlist_head bpf_prog_alloc_security;
>  	struct hlist_head bpf_prog_free_security;
>  #endif /* CONFIG_BPF_SYSCALL */
> +	struct hlist_head locked_down;
>  } __randomize_layout;
>  
>  /*
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 66a2fcbe6ab0..c2b1204e8e26 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -77,6 +77,33 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/*
> + * These are reasons that can be passed to the security_locked_down()
> + * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
> + * ability for userland to modify kernel code) are placed before
> + * LOCKDOWN_INTEGRITY_MAX.  Lockdown reasons that protect kernel
> + * confidentiality (ie, the ability for userland to extract
> + * information from the running kernel that would otherwise be
> + * restricted) are placed before LOCKDOWN_CONFIDENTIALITY_MAX.
> + *
> + * LSM authors should note that the semantics of any given lockdown
> + * reason are not guaranteed to be stable - the same reason may block
> + * one set of features in one kernel release, and a slightly different
> + * set of features in a later kernel release. LSMs that seek to expose
> + * lockdown policy at any level of granularity other than "none",
> + * "integrity" or "confidentiality" are responsible for either
> + * ensuring that they expose a consistent level of functionality to
> + * userland, or ensuring that userland is aware that this is
> + * potentially a moving target. It is easy to misuse this information
> + * in a way that could break userspace. Please be careful not to do
> + * so.
> + */
> +enum lockdown_reason {
> +	LOCKDOWN_NONE,
> +	LOCKDOWN_INTEGRITY_MAX,
> +	LOCKDOWN_CONFIDENTIALITY_MAX,
> +};
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> @@ -393,6 +420,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +int security_locked_down(enum lockdown_reason what);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -1205,6 +1233,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int security_locked_down(enum lockdown_reason what)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index 90f1e291c800..ce6c945bf347 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2392,3 +2392,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  	call_void_hook(bpf_prog_free_security, aux);
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
> +
> +int security_locked_down(enum lockdown_reason what)
> +{
> +	return call_int_hook(locked_down, 0, what);
> +}
> +EXPORT_SYMBOL(security_locked_down);
