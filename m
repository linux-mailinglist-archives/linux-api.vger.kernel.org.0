Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5165233A30
	for <lists+linux-api@lfdr.de>; Thu, 30 Jul 2020 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgG3U55 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jul 2020 16:57:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35216 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgG3U55 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jul 2020 16:57:57 -0400
Received: from static-50-53-58-29.bvtn.or.frontiernet.net ([50.53.58.29] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1k1FcZ-00015Y-NM; Thu, 30 Jul 2020 20:57:47 +0000
Subject: Re: [PATCH v19 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-api@vger.kernel.org
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-23-casey@schaufler-ca.com>
 <e885d90d-c873-5ab4-235d-6171f49f4ee4@canonical.com>
 <705fb82d-ad7a-2874-59ed-ba6bc7ae3722@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <97330b2d-5447-cfef-b6d0-444249e671b7@canonical.com>
Date:   Thu, 30 Jul 2020 13:57:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <705fb82d-ad7a-2874-59ed-ba6bc7ae3722@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/30/20 1:44 PM, Casey Schaufler wrote:
> On 7/30/2020 3:03 AM, John Johansen wrote:
>> On 7/24/20 1:32 PM, Casey Schaufler wrote:
>>> Add an entry /proc/.../attr/context which displays the full
>>> process security "context" in compound format:
>>>         lsm1\0value\0lsm2\0value\0...
>>> This entry is not writable.
>>>
>>> A security module may decide that its policy does not allow
>>> this information to be displayed. In this case none of the
>>> information will be displayed.
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> Cc: linux-api@vger.kernel.org
>>> ---
>>>  Documentation/security/lsm.rst       | 28 +++++++++++
>>>  fs/proc/base.c                       |  1 +
>>>  include/linux/lsm_hooks.h            |  6 +++
>>>  security/apparmor/include/procattr.h |  2 +-
>>>  security/apparmor/lsm.c              |  8 +++-
>>>  security/apparmor/procattr.c         | 22 +++++----
>>>  security/security.c                  | 70 ++++++++++++++++++++++++++++
>>>  security/selinux/hooks.c             |  2 +-
>>>  security/smack/smack_lsm.c           |  2 +-
>>>  9 files changed, 126 insertions(+), 15 deletions(-)
> 
> <snip>
> 
>>>  
>>>  /**
>>> diff --git a/security/security.c b/security/security.c
>>> index d35e578fa45b..bce6be720401 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -754,6 +754,48 @@ static void __init lsm_early_task(struct task_struct *task)
>>>  		panic("%s: Early task alloc failed.\n", __func__);
>>>  }
>>>  
>>> +/**
>>> + * append_ctx - append a lsm/context pair to a compound context
>>> + * @ctx: the existing compound context
>>> + * @ctxlen: size of the old context, including terminating nul byte
>>> + * @lsm: new lsm name, nul terminated
>>> + * @new: new context, possibly nul terminated
>>> + * @newlen: maximum size of @new
>>> + *
>>> + * replace @ctx with a new compound context, appending @newlsm and @new
>>> + * to @ctx. On exit the new data replaces the old, which is freed.
>>> + * @ctxlen is set to the new size, which includes a trailing nul byte.
>>> + *
>>> + * Returns 0 on success, -ENOMEM if no memory is available.
>>> + */
>>> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
>>> +		      int newlen)
>>> +{
>>> +	char *final;
>>> +	size_t llen;
>>> +
>>> +	llen = strlen(lsm) + 1;
>>> +	/*
>>> +	 * A security module may or may not provide a trailing nul on
>>> +	 * when returning a security context. There is no definition
>>> +	 * of which it should be, and there are modules that do it
>>> +	 * each way.
>>> +	 */
>>> +	newlen = strnlen(new, newlen) + 1;
>>> +
>>> +	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>>> +	if (final == NULL)
>>> +		return -ENOMEM;
>>> +	if (*ctxlen)
>>> +		memcpy(final, *ctx, *ctxlen);
>>> +	memcpy(final + *ctxlen, lsm, llen);
>>> +	memcpy(final + *ctxlen + llen, new, newlen);
>> if @new doesn't have a newline appended at its end this will read 1 byte
>> passed the end of the @new buffer. Nor will the result have a trailing
>> \0 as expected unless we get lucky.
> 
> @new will never have a newline at the end. The trailing nul comes
> from the allocation being done with kzalloc(). This function has to
> be considered in the context of its caller.
> 

ugh, sorry not trailing newline, I meant trailing \0. The problem isn't
the kzalloc, the target has the space. It is the source @new. It is
dangerous to assume that the @new buffer has a null byte after its
declared length. Which is potentially what we are doing if @new
doesn't have an embedded null byte. In that case strlen(new, newlen)
will then return newlen and we add 1 to it.

which means in the memcpy we are copying an extra byte beyond what
was declared to exist in @new.

>>
>>
>>> +	kfree(*ctx);
>>> +	*ctx = final;
>>> +	*ctxlen = *ctxlen + llen + newlen;
>>> +	return 0;
>>> +}
>>> +
>>>  /*
>>>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>>   * can be accessed with:
>>> @@ -2124,6 +2166,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>>  				char **value)
>>>  {
>>>  	struct security_hook_list *hp;
>>> +	char *final = NULL;
>>> +	char *cp;
>>> +	int rc = 0;
>>> +	int finallen = 0;
>> these are only used by context so they could be moved under its if, this
>> is really just a style comment and I'll leave it up to you
> 
> Old coding habits die hard. Unless there's value to gain, I'll leave it
> as is.
> 
>>
>>>  	int display = lsm_task_display(current);
>>>  	int slot = 0;
>>>  
>>> @@ -2151,6 +2197,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> +	if (!strcmp(name, "context")) {
>>> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>>> +				     list) {
>>> +			rc = hp->hook.getprocattr(p, "context", &cp);
>>> +			if (rc == -EINVAL)
>>> +				continue;
>>> +			if (rc < 0) {
>>> +				kfree(final);
>>> +				return rc;
>>> +			}
>>> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
>>> +					cp, rc);
>>> +			kfree(cp);
>>> +			if (rc < 0) {
>>> +				kfree(final);
>>> +				return rc;
>>> +			}
>>> +		}
>>> +		if (final == NULL)
>>> +			return -EINVAL;
>>> +		*value = final;
>>> +		return finallen;
>>> +	}
>>> +
>>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>>  			continue;
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index c13c207c5da1..43d5c09b9a9e 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -6288,7 +6288,7 @@ static int selinux_getprocattr(struct task_struct *p,
>>>  			goto bad;
>>>  	}
>>>  
>>> -	if (!strcmp(name, "current"))
>>> +	if (!strcmp(name, "current") || !strcmp(name, "context"))
>>>  		sid = __tsec->sid;
>>>  	else if (!strcmp(name, "prev"))
>>>  		sid = __tsec->osid;
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index 6f0cdb40addc..d7bb6442f192 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -3463,7 +3463,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>>>  	char *cp;
>>>  	int slen;
>>>  
>>> -	if (strcmp(name, "current") != 0)
>>> +	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
>>>  		return -EINVAL;
>>>  
>>>  	cp = kstrdup(skp->smk_known, GFP_KERNEL);
>>>

