Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79315B0C9
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLTQW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 14:16:22 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:37248 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLTQW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 14:16:22 -0500
X-EEMSG-check-017: 58270536|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="58270536"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 19:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581534977; x=1613070977;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Jz0eh88f4pVfKEwajqv0lyMcERzVgJd1p0qGrmWmFNY=;
  b=QrveYuahi7fb8CmLvaohtmHz41U0MMpziL1+PJGIc8os3ZkiRxRpsDU0
   HUKTYtOpYPCWTEQH+r4xF0Gen/PSJ14H4xdWuiTGYt1f9qbueqTEq7VVx
   dsUxom4ynfWjG5Df1TQnJFGwPoFKle2T8UPpdEWBlTMHxMKaJgiO3x7Sb
   iPYtqXId5mdlv6GRXszy/DeNtTwHeM3+jFYNJFDLOFUMpgbK9LoqCodZo
   Ia6pDEXql62NkrA6+jKhruD/xouLSSOuyLxmWRzOo7bz3QhUbJlCXhzSy
   E+lHW9+gv3ntF+vwz/oHNIJsd57ftI1FQ0Xyjk1Fg4NUUExLcICC2rb44
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39034280"
IronPort-PHdr: =?us-ascii?q?9a23=3AiZNZsh0zdvJ2wXBnsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUKPXxwZ3uMQTl6Ol3ixeRBMOHsq4C1bed6vq7EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctsYajZZ8Jqs/1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hEgEdwQvnTar9v7O6kdXu+30KbGwi7Ob+9V1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakML+/pVU/3qNPYCRs5Phe7w+bgD9V92YceVnyVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA55/7viH85nEIdfbOz3ZQNaHG1BftmI0?=
 =?us-ascii?q?KeYXrjhtcOD30GsRY5TOzvkFeCSyJcZ26uX6Ig4TE2EISmDYDYRoCtm7GB0y?=
 =?us-ascii?q?C7HppZZmBCFF+AC2vnd4KBW/0UciKdPtdhkiAYVbimU4Ih0xeutAzhxrpoKe?=
 =?us-ascii?q?rU/SIYtZb929Rv++LTkhQy/yRuD8uBy2GNU310nmQQSj8y26B/olJyykyD0a?=
 =?us-ascii?q?h3gvxXCMZT6OlSXwc1Mp7cyON6C9TsVQ7bYtiJT1OmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtWmjxDD2TeqArAMm7yIGpM06KTc0Gb1J8tm1XbG27cuj0M8TstMK2KmnK?=
 =?us-ascii?q?h/+BbXB4LTlEWZjamqf7wG3CHR7GeD0XaOvEZAXQ50UKXFW20fZ0TPodvj/k?=
 =?us-ascii?q?PCTqSjCaooMgRf086OMKhKZcPzjVVAWvjjPM7SY2Wrm2e/HRyI3K+DbJL2e2?=
 =?us-ascii?q?UB2yXQEFMEnB4X/XaHMwg+GyigrnnADDxhC13veVng8epgp3OhSE870QWKY1?=
 =?us-ascii?q?dm17qv9R5GzcCbHt8a2LMJvG8KrDF9B1282NTbQ46Mrgxqe6F0btQ671NKk2?=
 =?us-ascii?q?neslouEIanKvVZmlMGcwlx93jr3hFzB5QIxdMmt1s23QFyLuSey1oHeDSGi8?=
 =?us-ascii?q?OjcobLI3X/qUj8I5Xd3UvThZPPofYC?=
X-IPAS-Result: =?us-ascii?q?A2ClAwAWTkRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFoBSASKoQUiQOGZQEBAQEBAQaBEiWJcJBzA1QJAQEBAQEBAQEBNwQBAYRAA?=
 =?us-ascii?q?oJtOBMCEAEBAQUBAQEBAQUDAQFshQsBBTKCOykBgwIBBSMECwEFQRAJAg4KA?=
 =?us-ascii?q?gImAgJXBgoDBgIBAYJjP4JXJZEXm3l/M4kHgT6BDiqMPnmBB4ERJwwDgV9QL?=
 =?us-ascii?q?j6HW4JeBJAchkWBKpdrgkSCT5N8BhyCSIgSBYRFi3GsJiI3gSErCAIYCCEPg?=
 =?us-ascii?q?ydQGA2EVwGJUReOQSMDMJFhAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 19:16:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CJFJlr185197;
        Wed, 12 Feb 2020 14:15:19 -0500
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org
References: <20200211225547.235083-1-dancol@google.com>
 <20200211225547.235083-4-dancol@google.com>
 <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
 <CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com>
 <ae8adb92-9c6e-2318-a3b9-903ead3848b5@tycho.nsa.gov>
 <69f4ccce-18b2-42c1-71ac-3fe9caf2dfb6@tycho.nsa.gov>
 <CAKOZuevoKDYGVSooWAhi7Jr6Ww-+NEd-sStaPcN5Q6g+NKKRPQ@mail.gmail.com>
 <626a2302-5b5f-d7c1-fdef-51094bb1fe0d@tycho.nsa.gov>
Message-ID: <94b0d8bf-9990-6d3d-e9a6-aa761f191e55@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 14:17:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <626a2302-5b5f-d7c1-fdef-51094bb1fe0d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/12/20 2:11 PM, Stephen Smalley wrote:
> On 2/12/20 2:04 PM, Daniel Colascione wrote:
>> On Wed, Feb 12, 2020 at 10:59 AM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>>
>>> On 2/12/20 1:04 PM, Stephen Smalley wrote:
>>>> On 2/12/20 12:19 PM, Daniel Colascione wrote:
>>>>> Thanks for taking a look.
>>>>>
>>>>> On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov>
>>>>> wrote:
>>>>>>
>>>>>> On 2/11/20 5:55 PM, Daniel Colascione wrote:
>>>>>>> Use the secure anonymous inode LSM hook we just added to let SELinux
>>>>>>> policy place restrictions on userfaultfd use. The create operation
>>>>>>> applies to processes creating new instances of these file objects;
>>>>>>> transfer between processes is covered by restrictions on read, 
>>>>>>> write,
>>>>>>> and ioctl access already checked inside selinux_file_receive.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Colascione <dancol@google.com>
>>>>>>
>>>>>> (please add linux-fsdevel and viro to the cc for future versions 
>>>>>> of this
>>>>>> patch since it changes the VFS)
>>>>>>
>>>>>>> ---
>>>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>>>> index 1659b59fb5d7..e178f6f40e93 100644
>>>>>>> --- a/security/selinux/hooks.c
>>>>>>> +++ b/security/selinux/hooks.c
>>>>>>> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct
>>>>>>> inode *inode, struct inode *dir,
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * We shouldn't be creating secure anonymous inodes before LSM
>>>>>>> +      * initialization completes.
>>>>>>> +      */
>>>>>>> +     if (unlikely(!selinux_state.initialized))
>>>>>>> +             return -EBUSY;
>>>>>>
>>>>>> I don't think this is viable; any arbitrary actions are possible 
>>>>>> before
>>>>>> policy is loaded, and a Linux distro can be brought up fully with
>>>>>> SELinux enabled and no policy loaded.  You'll just need to have a
>>>>>> default behavior prior to initialization.
>>>>>
>>>>> We'd have to fail open then, I think, and return an S_PRIVATE inode
>>>>> (the regular anon inode).
>>>>
>>>> Not sure why.  You aren't doing anything in the hook that actually
>>>> relies on selinux_state.initialized being set (i.e. nothing requires a
>>>> policy).  The avc_has_perm() call will just succeed until a policy is
>>>> loaded.  So if these inodes are created prior to policy load, they will
>>>> get assigned the task SID (which would be the kernel SID prior to 
>>>> policy
>>>> load or first exec or write to /proc/self/attr/current afterward) and
>>>> UFFD class (in your current code), be permitted, and then once 
>>>> policy is
>>>> loaded any further access will get checked against the kernel SID.
>>>>
>>>>>>> +     /*
>>>>>>> +      * We only get here once per ephemeral inode.  The inode has
>>>>>>> +      * been initialized via inode_alloc_security but is otherwise
>>>>>>> +      * untouched, so check that the state is as
>>>>>>> +      * inode_alloc_security left it.
>>>>>>> +      */
>>>>>>> +     BUG_ON(isec->initialized != LABEL_INVALID);
>>>>>>> +     BUG_ON(isec->sclass != SECCLASS_FILE);
>>>>>>
>>>>>> I think the kernel discourages overuse of BUG_ON/BUG/...
>>>>>
>>>>> I'm not sure what counts as overuse.
>>>>
>>>> Me either (not my rule) but I'm pretty sure this counts or you'd see a
>>>> lot more of these kinds of BUG_ON() checks throughout.  Try to reserve
>>>> them for really critical cases.
>>>>
>>>>>>> +
>>>>>>> +#ifdef CONFIG_USERFAULTFD
>>>>>>> +     if (fops == &userfaultfd_fops)
>>>>>>> +             isec->sclass = SECCLASS_UFFD;
>>>>>>> +#endif
>>>>>>
>>>>>> Not sure we want or need to introduce a new security class for 
>>>>>> each user
>>>>>> of anonymous inodes since the permissions should be the same as for
>>>>>> file.
>>>>>
>>>>> The purpose of this change is to apply special policy to userfaultfd
>>>>> FDs in particular. Isn't having a UFFD security class the best way to
>>>>> go about that? (There's no path.) Am I missing something?
>>>>
>>>> It is probably the simplest approach; it just doesn't generalize to all
>>>> users of anonymous inodes. We can distinguish them in one of two ways:
>>>> use a different class like you did (requires a code change every 
>>>> time we
>>>> add a new one and yet another duplicate of the file class) or use a
>>>> different SID/context/type. The latter could be achieved by calling
>>>> security_transition_sid() with the provided name wrapped in a qstr and
>>>> specifying type_transition rules on the name.  Then policy could define
>>>> derived types for each domain, ala
>>>> type_transition init self:file "[userfaultfd]" init_userfaultfd;
>>>> type_transition untrusted_app self:file "[userfaultfd]"
>>>> untrusted_app_userfaultfd;
>>>> ...
>>>>
>>>>>> Also not sure we want to be testing fops for each such case.
>>>>>
>>>>> I was also thinking of just providing some kind of context string
>>>>> (maybe the name), which might be friendlier to modules, but the loose
>>>>> coupling kind of scares me, and for this particular application, since
>>>>> UFFD is always in the core and never in a module, checking the fops
>>>>> seems a bit more robust and doesn't hurt anything.
>>>>
>>>> Yes, not sure how the vfs folks feel about either coupling (the
>>>> name-based one or the fops-based one).  Neither seems great.
>>>>
>>>>>> We
>>>>>> were looking at possibly leveraging the name as a key and using
>>>>>> security_transition_sid() to generate a distinct SID/context/type for
>>>>>> the inode via type_transition rules in policy.  We have some WIP 
>>>>>> along
>>>>>> those lines.
>>>>>
>>>>> Where? Any chance it would be ready soon? I'd rather not hold up this
>>>>> work for a more general mechanism.
>>>>
>>>> Hopefully will have a patch available soon.  But not saying this
>>>> necessarily has to wait either.
>>>>
>>>>>>> +     /*
>>>>>>> +      * Always give secure anonymous inodes the sid of the
>>>>>>> +      * creating task.
>>>>>>> +      */
>>>>>>> +
>>>>>>> +     isec->sid = tsec->sid;
>>>>>>
>>>>>> This doesn't generalize for other users of anonymous inodes, e.g. the
>>>>>> /dev/kvm case where we'd rather inherit the SID and class from the
>>>>>> original /dev/kvm inode itself.
>>>>>
>>>>> I think someone mentioned on the first version of this patch that we
>>>>> could make it more flexible if the need arose. If we do want to do it
>>>>> now, we could have the anon_inode security hook accept a "parent" or
>>>>> "context" inode that modules could inspect for the purposes of forming
>>>>> the new inode's SID. Does that make sense to you?
>>>>
>>>> Yes, that's the approach in our current WIP, except we call it a
>>>> "related" inode since it isn't necessarily connected to the anon inode
>>>> in any vfs sense.
>>>
>>> The other key difference in our WIP approach is that we assumed that we
>>> couldn't mandate allocating a separate anon inode for each of these fds
>>> and we wanted to cover all anonymous inodes (not opt-in), so we are
>>> storing the SID/class pair as additional fields in the
>>> file_security_struct and have modified file_has_perm() and others to
>>> look there for anonymous inodes.
>>
>> A separate inode seems like the simpler approach for now, because it
>> means that we have fewer places to check for security information ---
>> and it's not as if an inode is particularly expensive. We can always
>> switch later.
> 
> We'd prefer having a separate inode if possible but didn't think that 
> would fly with the vfs folks, especially if we try to apply this to all 
> anonymous inodes. It might be ok for userfaultfd usage as a specific 
> case but there is a reason why anonymous inodes were introduced and 
> creating a separate inode each time defeats that purpose IIUC.  It will 
> be interesting to see how they respond.

I suppose an optimization of your approach could be to only allocate a 
new anon inode if there isn't already one that has the same security 
info (SID/class pair in the SELinux case).
