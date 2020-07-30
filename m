Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410082339EA
	for <lists+linux-api@lfdr.de>; Thu, 30 Jul 2020 22:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgG3Uof (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jul 2020 16:44:35 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:42553
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbgG3Uoe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jul 2020 16:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596141873; bh=NUwyH+1DGSLAHICDNKDIjA8VVnQnNL5u4r/9SE+k0L4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PbKVhgFQFMzlGBpUsPGRUGm7wIOByDB982Srg5JsaSTb7O9ghoy8f2+2RS50Yus4Gq25OKyHMqRM3ZL3sYKlRZgmbJ7mvD/lHPWlJb/p/iylVcRoGu74bCX8+t0I8ctyhWEXSWn6kxe72nHyXHuD+z4y4xLny02FZC8Diw+Beui66zwXsn06O+P7NPkxsSH++WgDsI227TD2jV3I9I5uNt81gmj6Fr86U4teeXJ3fmzTVKoQdbPEBYvYNo0VhPsyyyBqy6cFZppELilUj9f4MBNeq1nE8R6XYzPj3/UiukwH63Tiaj99PM5K/bqUUYRMEG6mopVvzLsWmdnhmisZ/g==
X-YMail-OSG: .wJXldUVM1lMEVnK45JcmYI1jSAvOuYVJK9Hqj_MKISP5IuCGtLZt6B145hDjra
 PSJraOmCdbrRUdqdehnrwiU9tAiAwGCpLbelx.WGQQA95AKjgygni3RXT9QPK4Vg10r3bzJBbnsY
 pjYUk3puh1ExH1pLXwGpeI386NuIShYvxbQRRkDzwIqOxxpaKp09N0vhhazMfrbUZIE9mnTYZGce
 dhMi1a4Tune9chxeXWZUsf3Cd8ywEEYcI2FvubXelTAGgdmwfrAdbOKIsrR8YjKVHW8j.o9W0Drx
 z_Ddc4xTq3pwPvW_SWVIn3w9sumw95IwunQCrCAA129vD1xcaE1hdhI6ysSjGgk71KF0x25nfAie
 NWMqzWJSHdSUtoRwXoROHACnjn_f0Dn6pVJWEZYWJNV2USCPvHtIXRMMOUv8kKaJ8IXAbUovzvf_
 .jd5vY6PvPvCas4zA7cJrJnChmqREcyWaEIhm6NTMnzuTnWdpxjhjaSCPFVxW75UnK5B9PMreMNa
 3JoqZ1iEHqnyUEGqgQtPVKgZJ66G.0y9e0133kAzwkqrlDUOTRuoW2XsxVYmHyiGBFgbs8SU.jyt
 M6_kdHZTDMSsNAOK62q_JvcOEPj0AqWxOMhpvCuWWbYXOw2F2K3egn5dPLXdohR06tAo42mCWdLU
 npLaaxyknWlEPnU8oyl66tkqp7khFXzwCNiTgyjCnyZ7AXumQMGlIDqZyxUmBhKIRvCmX0rG25DS
 FwQzWxG1QLr6pjOB4th6CUlDiVBrvVVwK2ypqdJSfcel3lpgGOQowGukLgp3eWGvbHbtljkU4uA4
 NxsoRrfPBibtrU74GJXonl.93uZbFycYnSw1gFd8ruevsQ_fbCSdY7kVQrlGE3XYc_x8BpFi2AFJ
 gdssMhgukFBIfw059.eHhcc_juB.UgTcF0KqGRtvZZb_vPtT4oFktGDhUwelIRVchWLARkjw.QD5
 LQXpH2GlRCL6MdLGESRMHClKgMKAGZ57W8LRXcADxKu1mKx0ncNyeweKM6hjJLi7yENpvEVtAs3M
 GOyTzs6ZrI.5CwgZLFKOxj.3yXyNam8Zo6CxDQnZoLyqqWwEwbCcgA_zTxHT6bdOhJ8wh4jbxVLh
 T2M3FQ3vUT6.j2lTvoQnez6LPX4E0R2vXIsHvMJuI_JNL_dAl.Qpv1w9.HZ0zzFQNXoTWrVZRHoX
 geWvztiWR1XaLpdSKNE_RdZtzDmijp1eXbet00mifGKI6sZH80BxTToZ2gXTTQjTxNVGlyfuf51p
 jd87efKbwm5rQMKMnnaKb_Ovi83KQWNs8U2uUA3.2ZZv6VY.N7T1vYwy5dvlegnPcp.FnKcnoMf.
 YSzudSRiLHA1gMLu3b24FTlGkLI2hmnTTFN4XQF081E4qHeyWfEvx6wyzI8pyjsJlhMaG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Jul 2020 20:44:33 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cfb25a5d97d1fc14526d3edb7919157d;
          Thu, 30 Jul 2020 20:44:31 +0000 (UTC)
Subject: Re: [PATCH v19 22/23] LSM: Add /proc attr entry for full LSM context
To:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-23-casey@schaufler-ca.com>
 <e885d90d-c873-5ab4-235d-6171f49f4ee4@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <705fb82d-ad7a-2874-59ed-ba6bc7ae3722@schaufler-ca.com>
Date:   Thu, 30 Jul 2020 13:44:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e885d90d-c873-5ab4-235d-6171f49f4ee4@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/30/2020 3:03 AM, John Johansen wrote:
> On 7/24/20 1:32 PM, Casey Schaufler wrote:
>> Add an entry /proc/.../attr/context which displays the full
>> process security "context" in compound format:
>>         lsm1\0value\0lsm2\0value\0...
>> This entry is not writable.
>>
>> A security module may decide that its policy does not allow
>> this information to be displayed. In this case none of the
>> information will be displayed.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-api@vger.kernel.org
>> ---
>>  Documentation/security/lsm.rst       | 28 +++++++++++
>>  fs/proc/base.c                       |  1 +
>>  include/linux/lsm_hooks.h            |  6 +++
>>  security/apparmor/include/procattr.h |  2 +-
>>  security/apparmor/lsm.c              |  8 +++-
>>  security/apparmor/procattr.c         | 22 +++++----
>>  security/security.c                  | 70 ++++++++++++++++++++++++++++
>>  security/selinux/hooks.c             |  2 +-
>>  security/smack/smack_lsm.c           |  2 +-
>>  9 files changed, 126 insertions(+), 15 deletions(-)

<snip>

>>  
>>  /**
>> diff --git a/security/security.c b/security/security.c
>> index d35e578fa45b..bce6be720401 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -754,6 +754,48 @@ static void __init lsm_early_task(struct task_struct *task)
>>  		panic("%s: Early task alloc failed.\n", __func__);
>>  }
>>  
>> +/**
>> + * append_ctx - append a lsm/context pair to a compound context
>> + * @ctx: the existing compound context
>> + * @ctxlen: size of the old context, including terminating nul byte
>> + * @lsm: new lsm name, nul terminated
>> + * @new: new context, possibly nul terminated
>> + * @newlen: maximum size of @new
>> + *
>> + * replace @ctx with a new compound context, appending @newlsm and @new
>> + * to @ctx. On exit the new data replaces the old, which is freed.
>> + * @ctxlen is set to the new size, which includes a trailing nul byte.
>> + *
>> + * Returns 0 on success, -ENOMEM if no memory is available.
>> + */
>> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
>> +		      int newlen)
>> +{
>> +	char *final;
>> +	size_t llen;
>> +
>> +	llen = strlen(lsm) + 1;
>> +	/*
>> +	 * A security module may or may not provide a trailing nul on
>> +	 * when returning a security context. There is no definition
>> +	 * of which it should be, and there are modules that do it
>> +	 * each way.
>> +	 */
>> +	newlen = strnlen(new, newlen) + 1;
>> +
>> +	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>> +	if (final == NULL)
>> +		return -ENOMEM;
>> +	if (*ctxlen)
>> +		memcpy(final, *ctx, *ctxlen);
>> +	memcpy(final + *ctxlen, lsm, llen);
>> +	memcpy(final + *ctxlen + llen, new, newlen);
> if @new doesn't have a newline appended at its end this will read 1 byte
> passed the end of the @new buffer. Nor will the result have a trailing
> \0 as expected unless we get lucky.

@new will never have a newline at the end. The trailing nul comes
from the allocation being done with kzalloc(). This function has to
be considered in the context of its caller.

>
>
>> +	kfree(*ctx);
>> +	*ctx = final;
>> +	*ctxlen = *ctxlen + llen + newlen;
>> +	return 0;
>> +}
>> +
>>  /*
>>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>   * can be accessed with:
>> @@ -2124,6 +2166,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>  				char **value)
>>  {
>>  	struct security_hook_list *hp;
>> +	char *final = NULL;
>> +	char *cp;
>> +	int rc = 0;
>> +	int finallen = 0;
> these are only used by context so they could be moved under its if, this
> is really just a style comment and I'll leave it up to you

Old coding habits die hard. Unless there's value to gain, I'll leave it
as is.

>
>>  	int display = lsm_task_display(current);
>>  	int slot = 0;
>>  
>> @@ -2151,6 +2197,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>  		return -ENOMEM;
>>  	}
>>  
>> +	if (!strcmp(name, "context")) {
>> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>> +				     list) {
>> +			rc = hp->hook.getprocattr(p, "context", &cp);
>> +			if (rc == -EINVAL)
>> +				continue;
>> +			if (rc < 0) {
>> +				kfree(final);
>> +				return rc;
>> +			}
>> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
>> +					cp, rc);
>> +			kfree(cp);
>> +			if (rc < 0) {
>> +				kfree(final);
>> +				return rc;
>> +			}
>> +		}
>> +		if (final == NULL)
>> +			return -EINVAL;
>> +		*value = final;
>> +		return finallen;
>> +	}
>> +
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index c13c207c5da1..43d5c09b9a9e 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6288,7 +6288,7 @@ static int selinux_getprocattr(struct task_struct *p,
>>  			goto bad;
>>  	}
>>  
>> -	if (!strcmp(name, "current"))
>> +	if (!strcmp(name, "current") || !strcmp(name, "context"))
>>  		sid = __tsec->sid;
>>  	else if (!strcmp(name, "prev"))
>>  		sid = __tsec->osid;
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 6f0cdb40addc..d7bb6442f192 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3463,7 +3463,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>>  	char *cp;
>>  	int slen;
>>  
>> -	if (strcmp(name, "current") != 0)
>> +	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
>>  		return -EINVAL;
>>  
>>  	cp = kstrdup(skp->smk_known, GFP_KERNEL);
>>
