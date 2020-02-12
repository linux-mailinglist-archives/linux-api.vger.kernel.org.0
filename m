Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637E415B05A
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLS7F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 13:59:05 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:61207 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLS7E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 13:59:04 -0500
X-EEMSG-check-017: 70998748|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="70998748"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 18:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581533922; x=1613069922;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=43MVO/510jhOyan+SGnwcFXKAXlzAUm+RrV08a9G7Q0=;
  b=qpJLBj7tzkjmoFtcMlhe7MMJ6/MzRhSFnv6bxUhRpaB7fTLF7OZ3EOl/
   GrN9kPzPFG1MLKatxB+bLPxPW0p05cmgPik5dF55GY387j8OkdvVD+DIN
   xROXyUmqz8r/Qyt+Q3+BaSicnZvE/BJpkPVK7BV8Rfc2DVA7Z30PnB+QB
   rC+BLGTL0dYFqbPeNn0gadUnFOfMaJtk9qaQZxks8dUCcoQldiTKP8AQV
   ClRvrurcCUiVbb0pPk0BDfic/bJ2hH5yOWA1SNQRyiq2nFAuRCBL1pPK9
   +uLkcI2GnSwv/w6QJDG73vvFJLvsGhu/SGT8lxZLqw1tu5vaDk1Ey/4Ao
   g==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39033152"
IronPort-PHdr: =?us-ascii?q?9a23=3Ax3SjNRQDn8JHqiTu9aM+W5L1I9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhaOt8tkgFKBZ4jH8fUM07OQ7/m8HzJdqs/b6TgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4pvJ6Y+xh?=
 =?us-ascii?q?fUvHdEZvldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWW?=
 =?us-ascii?q?pBRdtaWyhYDo+hc4cDE+8NMOBWoInno1sFsAWwCw+iCujyzjNEn3H70Kk/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrJrNv7KqkSX+O7wqbGwjrMbe9Z1zjm5YjUcR0su+2AUa?=
 =?us-ascii?q?5+fMfTz0QkCgPLjk+XqYzgJz6by/gNvHaD7+pgS+2vjXMspRx0oje1wscsjp?=
 =?us-ascii?q?fGh4IIwV3D7iV23Z01KMakSE97fdGkEJxQuzucN4ttWMwuWW5ouCEkyrAfv5?=
 =?us-ascii?q?OwYSsEyIw/yhLCZPGKfJKE7xL+WOqLPzt1i2xpdKiiixu07EOu0PfzVtOu31?=
 =?us-ascii?q?ZPtidFl97MuW0T2BHL8ciHT+d9/l+m2TaSywDf8uFELl4wlarcM5Mh3qQ/lo?=
 =?us-ascii?q?ASsUTeBS/6gkT2jKmYdkUj4ein9fjobq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudPFFBA5NRC7w+HjCNhm2YMeXmWPAq?=
 =?us-ascii?q?CdMKzMq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhhV8dfKyp3Z4KaHCiBPRpOU?=
 =?us-ascii?q?WYbGHjgtcGFmcKsQ4+Q/LwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5irgLyGxy?=
 =?us-ascii?q?e7HoZbZm9BClCLHnfoc5uLV+0QZyKVJ89riiYEWqS5S489yRGusxf3y7xhLu?=
 =?us-ascii?q?rX4SAYupXj1N965+3Xix4+7yB7D8OY02uVVWF7gnsIRyMq3KB4uUF9zlCD0a?=
 =?us-ascii?q?tmjPxDFdxT6PJJXRogNZHG1OF6BNfyWgXOfteNVlmqWMmpATY0Ttgp2d8Bf1?=
 =?us-ascii?q?59G8m+jhDExyeqB74Vl7qWBJ07667c3Gb+J9x7y3nY0KkslEcmQsRROm28nK?=
 =?us-ascii?q?J/9BbcB5TPk0qHk6amb6Mc3DTC9G2b12qBoFlYUBJsUaXCRX0fYkrWrdLk5k?=
 =?us-ascii?q?LNVrOhE6wnMgpaxM6cJatFdMfpgU9FRPj9ItTeZXy+m2OqCRaP3LOMY5Lge3?=
 =?us-ascii?q?8B0yXFFEgEjwcT8G6dNQcgAiehomTeDCFhFF/0fUPs/vdxqGmhQk830Q6KdU?=
 =?us-ascii?q?th2KSx+hIPgvycUfwTjfo4v3INojN1EVL19NXSAsGLpg1nce0Ibdo761BD/W?=
 =?us-ascii?q?3esAN5M9qrKKU01XAEdAEihF/jzxV6DM17lMEuqH47hF5pJbmwzEJKdzTe24?=
 =?us-ascii?q?v5fLLQND+hr1iUd6fK1wSGg56t8aAV5aF98g6ysQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwBABeSkRe/wHyM5BmHQEBAQkBEQUFAYF7gXgFgWgFI?=
 =?us-ascii?q?BIqhBSJA4ZlAQEBAQEBBoE3iXCQcwNUCQEBAQEBAQEBATcEAQGEQAKCbTgTA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIULAQUygjspAYMCAQUjBAsBBUEQCQIOCgICJgICV?=
 =?us-ascii?q?wYKAwYCAQGCYz+CVyWQdpt5fzOJFIE+gQ4qjD55gQeBEScPgV9QLj6HW4JeB?=
 =?us-ascii?q?JAchkWBKogyjzmCRIJPk3wGHIJIiBIFhEWLcawmIjeBISsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?YRXAYlRF45BIwMwkWEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 18:58:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CIvj96175718;
        Wed, 12 Feb 2020 13:57:45 -0500
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
Message-ID: <69f4ccce-18b2-42c1-71ac-3fe9caf2dfb6@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 13:59:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ae8adb92-9c6e-2318-a3b9-903ead3848b5@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/12/20 1:04 PM, Stephen Smalley wrote:
> On 2/12/20 12:19 PM, Daniel Colascione wrote:
>> Thanks for taking a look.
>>
>> On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>>
>>> On 2/11/20 5:55 PM, Daniel Colascione wrote:
>>>> Use the secure anonymous inode LSM hook we just added to let SELinux
>>>> policy place restrictions on userfaultfd use. The create operation
>>>> applies to processes creating new instances of these file objects;
>>>> transfer between processes is covered by restrictions on read, write,
>>>> and ioctl access already checked inside selinux_file_receive.
>>>>
>>>> Signed-off-by: Daniel Colascione <dancol@google.com>
>>>
>>> (please add linux-fsdevel and viro to the cc for future versions of this
>>> patch since it changes the VFS)
>>>
>>>> ---
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index 1659b59fb5d7..e178f6f40e93 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct 
>>>> inode *inode, struct inode *dir,
>>>> +
>>>> +     /*
>>>> +      * We shouldn't be creating secure anonymous inodes before LSM
>>>> +      * initialization completes.
>>>> +      */
>>>> +     if (unlikely(!selinux_state.initialized))
>>>> +             return -EBUSY;
>>>
>>> I don't think this is viable; any arbitrary actions are possible before
>>> policy is loaded, and a Linux distro can be brought up fully with
>>> SELinux enabled and no policy loaded.  You'll just need to have a
>>> default behavior prior to initialization.
>>
>> We'd have to fail open then, I think, and return an S_PRIVATE inode
>> (the regular anon inode).
> 
> Not sure why.  You aren't doing anything in the hook that actually 
> relies on selinux_state.initialized being set (i.e. nothing requires a 
> policy).  The avc_has_perm() call will just succeed until a policy is 
> loaded.  So if these inodes are created prior to policy load, they will 
> get assigned the task SID (which would be the kernel SID prior to policy 
> load or first exec or write to /proc/self/attr/current afterward) and 
> UFFD class (in your current code), be permitted, and then once policy is 
> loaded any further access will get checked against the kernel SID.
> 
>>>> +     /*
>>>> +      * We only get here once per ephemeral inode.  The inode has
>>>> +      * been initialized via inode_alloc_security but is otherwise
>>>> +      * untouched, so check that the state is as
>>>> +      * inode_alloc_security left it.
>>>> +      */
>>>> +     BUG_ON(isec->initialized != LABEL_INVALID);
>>>> +     BUG_ON(isec->sclass != SECCLASS_FILE);
>>>
>>> I think the kernel discourages overuse of BUG_ON/BUG/...
>>
>> I'm not sure what counts as overuse.
> 
> Me either (not my rule) but I'm pretty sure this counts or you'd see a 
> lot more of these kinds of BUG_ON() checks throughout.  Try to reserve 
> them for really critical cases.
> 
>>>> +
>>>> +#ifdef CONFIG_USERFAULTFD
>>>> +     if (fops == &userfaultfd_fops)
>>>> +             isec->sclass = SECCLASS_UFFD;
>>>> +#endif
>>>
>>> Not sure we want or need to introduce a new security class for each user
>>> of anonymous inodes since the permissions should be the same as for
>>> file.
>>
>> The purpose of this change is to apply special policy to userfaultfd
>> FDs in particular. Isn't having a UFFD security class the best way to
>> go about that? (There's no path.) Am I missing something?
> 
> It is probably the simplest approach; it just doesn't generalize to all 
> users of anonymous inodes. We can distinguish them in one of two ways: 
> use a different class like you did (requires a code change every time we 
> add a new one and yet another duplicate of the file class) or use a 
> different SID/context/type. The latter could be achieved by calling 
> security_transition_sid() with the provided name wrapped in a qstr and 
> specifying type_transition rules on the name.  Then policy could define 
> derived types for each domain, ala
> type_transition init self:file "[userfaultfd]" init_userfaultfd;
> type_transition untrusted_app self:file "[userfaultfd]" 
> untrusted_app_userfaultfd;
> ...
> 
>>> Also not sure we want to be testing fops for each such case.
>>
>> I was also thinking of just providing some kind of context string
>> (maybe the name), which might be friendlier to modules, but the loose
>> coupling kind of scares me, and for this particular application, since
>> UFFD is always in the core and never in a module, checking the fops
>> seems a bit more robust and doesn't hurt anything.
> 
> Yes, not sure how the vfs folks feel about either coupling (the 
> name-based one or the fops-based one).  Neither seems great.
> 
>>> We
>>> were looking at possibly leveraging the name as a key and using
>>> security_transition_sid() to generate a distinct SID/context/type for
>>> the inode via type_transition rules in policy.  We have some WIP along
>>> those lines.
>>
>> Where? Any chance it would be ready soon? I'd rather not hold up this
>> work for a more general mechanism.
> 
> Hopefully will have a patch available soon.  But not saying this 
> necessarily has to wait either.
> 
>>>> +     /*
>>>> +      * Always give secure anonymous inodes the sid of the
>>>> +      * creating task.
>>>> +      */
>>>> +
>>>> +     isec->sid = tsec->sid;
>>>
>>> This doesn't generalize for other users of anonymous inodes, e.g. the
>>> /dev/kvm case where we'd rather inherit the SID and class from the
>>> original /dev/kvm inode itself.
>>
>> I think someone mentioned on the first version of this patch that we
>> could make it more flexible if the need arose. If we do want to do it
>> now, we could have the anon_inode security hook accept a "parent" or
>> "context" inode that modules could inspect for the purposes of forming
>> the new inode's SID. Does that make sense to you?
> 
> Yes, that's the approach in our current WIP, except we call it a 
> "related" inode since it isn't necessarily connected to the anon inode 
> in any vfs sense.

The other key difference in our WIP approach is that we assumed that we 
couldn't mandate allocating a separate anon inode for each of these fds 
and we wanted to cover all anonymous inodes (not opt-in), so we are 
storing the SID/class pair as additional fields in the 
file_security_struct and have modified file_has_perm() and others to 
look there for anonymous inodes.
