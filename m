Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922DF22BB39
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 03:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXBIU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Jul 2020 21:08:20 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41173
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgGXBIT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Jul 2020 21:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595552897; bh=BGhBnVZ36lfgPQJOoPMAOW/Fd8fTrp3EpyJrBAb9q60=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LC7733TiBAPB9Qy64+BmIDWmaWHmdirYSNr0RYUKVJbyeSAKs0Acim1Jjn7BdTXva1GQTs1edaalspXRTWkw0UP0zbUM/nTSzhTzptff5NHT8s7iWpW0elvQRhx6sdcF+Zf09HyByPPmcYph/04pi7lKhES+PIx14XZ+iWWQWVnzvfCp3287bCbpbpAA8/hig62kOkccZzJvkzzl61oLc+lRC3dy23dJ68lbA9Imnc6/omx4WzDfNnmEzc0AJ7ZQ+6b9dSTnzUxlKtz2v6enKLEfXT7w+w+2hTSqsyHs1K9ZHzDS4XOsQ5Q8oclq1xeVy8rV9IMx/Iem3/a1R5HB+Q==
X-YMail-OSG: HsC6jAEVM1kNM5nyMormSWr8__RJYfS81LnmL8QtT78WmABm_bUwlLrBOL5pt33
 Mu7qD3QBGQadP6jcveLCPmDuGpWikzgBrORf7HMhu_ot.fNZy9UgOCqUCWKO2FXHrSe8XWsHQjPg
 Ther4eMWoEEmtTRzh7pi9O.VIg3o31LOTFxC5QPb9KEndL6I296jx5GEah8jCoEJfdls3h4ICgek
 SMu3_DUyhDVisvqvglecbB7xbtZYwgEwbmkfiCViHfn7Wbu48JY63gmyQKqnFBnwnCAmZ_C7shgV
 9Iq_vA1Lpa9QQ3NHBHgYU8QuUTiHS6YzhtDWFGiuYDojTl0TtP5.gm6ofK.bidjmiJkiTvIcYtGS
 HOKP8cGLfvzs.kvHU4xPGkAxGeyEsHh37PfykhFHQQAP5izyJe_x97ciXmv2Q_aDkldZvkOsJqp1
 GjrujN8qZaRm5vVlEAFuE9SvhwjWPJvnHZsBWomPv4eFUMbRloIsTk6cdfrhCPfEEYSVUQ9kN4Fh
 prxbX1tjAiFyh3euN0TpWSiGH6KhhtVWxOu2vQQSPa2LbpV8NmMNRSroJ__USkjbH2SUpamjW5Ma
 prS5jlRTZ1W1oAyTey90DeTxgxKt7rxA.9aSDr0YlefvvHxsKtNqF4w8eIA_p6S22xGxW5C_I9cI
 4wfhZcT72kuN1xOORTeIQeLhjlQVIc8DPncnx51YJtmJ9Lg_mQfkWHkSR.J2zbMaD46x2MLUmlBw
 gsg18z1DeK6gAuOjGe1blxJ_kezucNd5_GKVxeWtNfyD8kLwyqaq_QR5JPVlv4IqfLJ4RQo2tDys
 o6ukhmX_tI7aXVJpdNB1Xq_nls3pLPArHdOTX6ef_pAeRl_S4XbOph8iuUeyBq_f6dOZSISiKZfc
 AbFuhcZMTSZ4f3T3k3sfXf94OSsVQ3peIW9OC4yaj6wqynpdpfA7B9PpNKzADekEI0D0zCG.Ij60
 dStZ43B_3xKphGHJnfs_dFNVxZkZRMmhgczWOz_f8ZhkQKRXbqI9Fv8fLbU2tQKCr.1z5ztw7bbs
 miOztMkuUU4YPOGvxl2JgqqrSg9EDfQAaK9Rpc363I3.GS4Vc2KjpAjPCg.qSQIigmLoksPI59Qa
 6LxpSOQi6JY9WHwW0C2DArqRf8.Tl3wjZCUAorgeXPR3u5KjpB_J7yi55_if1kTIbyc91U9eFyUT
 WsTvrn45tOfcbd2v90jySboLLbfGhawq6HvWtTI9_k7saUs071K7kUqt5gh.ISakf2UzNSviirAq
 gjCLL90S356FvX17MtASeYALD4fjW0Th9R1fXf.b4jrQVXKPoKT8okDk6YdVbqNumdAWFIYA5QYZ
 zbYgwh8P_PHzePYfEx9vdJ6CgFHQm1i8i5SQUFIdDToHuupUwq2yXu6vC83Kcrsw.g8z7reY664r
 bWkHV4X8Vg4f6mQOA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jul 2020 01:08:17 +0000
Received: by smtp430.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f8dad607261856b6c438236bb129fb35;
          Fri, 24 Jul 2020 01:08:14 +0000 (UTC)
Subject: Re: [PATCH v18 22/23] LSM: Add /proc attr entry for full LSM context
To:     Jann Horn <jannh@google.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux API <linux-api@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
 <20200709001234.9719-23-casey@schaufler-ca.com>
 <CAG48ez36_+0k4ubaHRq=9gVDQspUh6yXkAeMRV=cEy-oyOr-sg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f1d8966f-1b96-49da-9bf9-b409835b8968@schaufler-ca.com>
Date:   Thu, 23 Jul 2020 18:08:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez36_+0k4ubaHRq=9gVDQspUh6yXkAeMRV=cEy-oyOr-sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/8/2020 6:30 PM, Jann Horn wrote:
> On Thu, Jul 9, 2020 at 2:42 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add an entry /proc/.../attr/context which displays the full
>> process security "context" in compound format:
>>         lsm1\0value\0lsm2\0value\0...
>> This entry is not writable.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-api@vger.kernel.org
> [...]
>> diff --git a/security/security.c b/security/security.c
> [...]
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
>> +                     int newlen)
>> +{
>> +       char *final;
>> +       int llen;
> Please use size_t to represent object sizes

OK.

> , instead of implicitly
> truncating them and assuming that that doesn't wrap. Using "int" here
> not only makes it harder to statically reason about this code, it
> actually can also make the generated code worse:
>
>
> $ cat numtrunc.c
> #include <stddef.h>
>
> size_t my_strlen(char *p);
> void *my_alloc(size_t len);
>
> void *blah_trunc(char *p) {
>   int len = my_strlen(p) + 1;
>   return my_alloc(len);
> }
>
> void *blah_notrunc(char *p) {
>   size_t len = my_strlen(p) + 1;
>   return my_alloc(len);
> }
> $ gcc -O2 -c -o numtrunc.o numtrunc.c
> $ objdump -d numtrunc.o
> [...]
> 0000000000000000 <blah_trunc>:
>    0: 48 83 ec 08          sub    $0x8,%rsp
>    4: e8 00 00 00 00        callq  9 <blah_trunc+0x9>
>    9: 48 83 c4 08          add    $0x8,%rsp
>    d: 8d 78 01              lea    0x1(%rax),%edi
>   10: 48 63 ff              movslq %edi,%rdi    <<<<<<<<unnecessary instruction
>   13: e9 00 00 00 00        jmpq   18 <blah_trunc+0x18>
> [...]
> 0000000000000020 <blah_notrunc>:
>   20: 48 83 ec 08          sub    $0x8,%rsp
>   24: e8 00 00 00 00        callq  29 <blah_notrunc+0x9>
>   29: 48 83 c4 08          add    $0x8,%rsp
>   2d: 48 8d 78 01          lea    0x1(%rax),%rdi
>   31: e9 00 00 00 00        jmpq   36 <blah_notrunc+0x16>
> $
>
> This is because GCC documents
> (https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html) that
> for integer conversions where the value does not fit into the signed
> target type, "the value is reduced modulo 2^N to be within range of
> the type"; so the compiler has to assume that you are actually
> intentionally trying to truncate the more significant bits from the
> length, and therefore may have to insert extra code to ensure that
> this truncation happens.
>
>
>> +       llen = strlen(lsm) + 1;
>> +       newlen = strnlen(new, newlen) + 1;
> This strnlen() call seems dodgy. If an LSM can return a string that
> already contains null bytes, shouldn't that be considered a bug, given
> that it can't be displayed properly? Would it be more appropriate to
> have a WARN_ON(memchr(new, '\0', newlen)) check here and bail out if
> that happens?

Whether or not a security module should include a trailing nul has
been a matter of some discussion. Alas, the discussion has not reached
conscensus. The strnlen() is here to allow modules their own convention. 

>
>> +       final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
>> +       if (final == NULL)
>> +               return -ENOMEM;
>> +       if (*ctxlen)
>> +               memcpy(final, *ctx, *ctxlen);
>> +       memcpy(final + *ctxlen, lsm, llen);
>> +       memcpy(final + *ctxlen + llen, new, newlen);
>> +       kfree(*ctx);
>> +       *ctx = final;
>> +       *ctxlen = *ctxlen + llen + newlen;
>> +       return 0;
>> +}
>> +
>>  /*
>>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>   * can be accessed with:
>> @@ -2109,6 +2145,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>                                 char **value)
>>  {
>>         struct security_hook_list *hp;
>> +       char *final = NULL;
>> +       char *cp;
>> +       int rc = 0;
>> +       int finallen = 0;
>>         int display = lsm_task_display(current);
>>         int slot = 0;
>>
> [...]
>>                 return -ENOMEM;
>>         }
>>
>> +       if (!strcmp(name, "context")) {
>> +               hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
>> +                                    list) {
>> +                       rc = hp->hook.getprocattr(p, "context", &cp);
>> +                       if (rc == -EINVAL)
>> +                               continue;
>> +                       if (rc < 0) {
>> +                               kfree(final);
>> +                               return rc;
>> +                       }
> This means that if SELinux refuses to give the caller PROCESS__GETATTR
> access to the target process, the entire "context" file will refuse to
> show anything, even if e.g. an AppArmor label would be visible through
> the LSM-specific attribute directory, right?

That is correct.

>  That seems awkward.

Sure is.

>  Can
> you maybe omit context elements for which the access check failed
> instead, or embed an extra flag byte to signal for each element
> whether the lookup failed, or something along those lines?

The SELinux team seems convinced that if their check fails, the
whole thing must fail. 

> If this is an intentional design limitation, it should probably be
> documented in the commit message or so.

Point.

>
>> +                       rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
>> +                                       cp, rc);
>> +                       if (rc < 0) {
>> +                               kfree(final);
>> +                               return rc;
>> +                       }
> Isn't there a memory leak here?

Why yes, there is.

>  `cp` points to memory that was
> allocated by hp->hook.getprocattr(), and you're not freeing it after
> append_ctx(). (And append_ctx() also doesn't free it.)
>
>> +               }
>> +               if (final == NULL)
>> +                       return -EINVAL;
>> +               *value = final;
>> +               return finallen;
>> +       }
>> +
>>         hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>                 if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>                         continue;
