Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E915B07B
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLTKc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 14:10:32 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:65299 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLTKc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 14:10:32 -0500
X-EEMSG-check-017: 55406550|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="55406550"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 19:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581534630; x=1613070630;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mN3WfSXukm2K2tBf1ALMyiXh8+TE4lFvkRSGFW68lm4=;
  b=XWsF4yApO5YlbvI/R9NATGfXYrAqgJeVsC5eB2rSlhcWh7yLGm5JAKTz
   iEvNmmUmWGpBfJIZ/UJbIPy/j0utYWJG0RWM5EOsTix6E+6IACUYfPpgB
   0GGFLSNAePMEXvw7AnZQkr9NvLhoASAUqhHn+cfDwK7M0gR2wYxkTOrjT
   CDMs8p+Dln6+fxvUG68x3KVJBrk2oPDZCxHaorBx3rJgzGJbfBcjF8PIc
   p+N7iSvdVCtJzimdu8GfcDHAcKJHTGDhJ53MXZXXmkMvEVa55CPbQGUE8
   6kPPLnXZVzCEfUY7rIn1tUXkLxWvfmAqUQSc+0l0TlnMp7+1QrH7h8cn5
   w==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="32991373"
IronPort-PHdr: =?us-ascii?q?9a23=3ARqfBRBPZFVIixabE3ggl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/75rsbcNUDSrc9gkEXOFd2Cra4d16yI7uu5AzVIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Qu8QWjoduN7g9xg?=
 =?us-ascii?q?bUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/8R1X+tNrEAR8+Nwy52OnnCNJ61oMRXWKAHL?=
 =?us-ascii?q?WVP7/VsV+N/ugvOfWDZJcJuDbhLPgo/+LujX48mV8YYKmpx4EXZ2q4H/l9LE?=
 =?us-ascii?q?WZZn3sgtgFEWgUpAYxUOvqiFiaWz5Je3myR7485i08CI++C4fDQZutgLya0S?=
 =?us-ascii?q?e0GZ1WYW9GClSSHnvya4qEXPIMYjqIIsB9ijwESaShS4g52BGosg/6yKFqLu?=
 =?us-ascii?q?XT+i0fupLj0MZ66/fPmhE18Dx+F96d3H2VT2FogmMIQCc73KR4oUx+1FiDyq?=
 =?us-ascii?q?h4g/NZFdNO/fNGSBw3NZHbz+x9BNDyXhzOcs2VR1ahR9WsGSsxQc4pw98Sf0?=
 =?us-ascii?q?Z9HM2vjhTC3yqsHr8UmKWHBJ8q/aLG2Xj+OcJ9xm3Y1KkukVYmWNFDNW64ia?=
 =?us-ascii?q?5l8QjcGYrJn1+el6aweqQWxDTN+3ubzWqSoEFYVxZ9UaHEXXAZe0vXos316V?=
 =?us-ascii?q?naT7+vErknLARBxtCYKqdQad3mk09GRPH9N9TaeW6xnH2wBRmQzLOWcIXqY3?=
 =?us-ascii?q?kd3DnaCEUciAAc43KGNQk4Bie8rGPTFyJuFV3xbEP26+V+q220TlUyzw6Ua0?=
 =?us-ascii?q?1tzb21+gQaha/Ud/RG8rsCuSol4x5zGF+m1NPRDdfI8wZoeq5bZfsy51BI0W?=
 =?us-ascii?q?+fvAt4aM+ONadn02UCfhx3skWm7BB+DoFNgIB+t38x5BZjIqKfllVafnWX2o?=
 =?us-ascii?q?6mae6fEXX74B36M/2e4VrZytvDv/5Uufk=3D?=
X-IPAS-Result: =?us-ascii?q?A2APAwC1TERe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBaAUgEiqEFIkDhmUBAQEBAQEGgTeJcJBzA1QJAQEBAQEBAQEBNwQBAYRAA?=
 =?us-ascii?q?oJtOBMCEAEBAQUBAQEBAQUDAQFshQsBBTKCOykBgwIBBSMEEUEQCw4KAgImA?=
 =?us-ascii?q?gJXBgoDBgIBAYJjP4JXJa0LfzOFSoNAgT6BDiqMPnmBB4ERJw+BX1AuPodbg?=
 =?us-ascii?q?l4EkByGRWRGl2uCRIJPk3wGHIJIiBIFhEWLcawmIjeBISsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?YRXAYlRF45BIwMwkWEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Feb 2020 19:10:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CJ9QC3185134;
        Wed, 12 Feb 2020 14:09:26 -0500
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <626a2302-5b5f-d7c1-fdef-51094bb1fe0d@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 14:11:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuevoKDYGVSooWAhi7Jr6Ww-+NEd-sStaPcN5Q6g+NKKRPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/12/20 2:04 PM, Daniel Colascione wrote:
> On Wed, Feb 12, 2020 at 10:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 2/12/20 1:04 PM, Stephen Smalley wrote:
>>> On 2/12/20 12:19 PM, Daniel Colascione wrote:
>>>> Thanks for taking a look.
>>>>
>>>> On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov>
>>>> wrote:
>>>>>
>>>>> On 2/11/20 5:55 PM, Daniel Colascione wrote:
>>>>>> Use the secure anonymous inode LSM hook we just added to let SELinux
>>>>>> policy place restrictions on userfaultfd use. The create operation
>>>>>> applies to processes creating new instances of these file objects;
>>>>>> transfer between processes is covered by restrictions on read, write,
>>>>>> and ioctl access already checked inside selinux_file_receive.
>>>>>>
>>>>>> Signed-off-by: Daniel Colascione <dancol@google.com>
>>>>>
>>>>> (please add linux-fsdevel and viro to the cc for future versions of this
>>>>> patch since it changes the VFS)
>>>>>
>>>>>> ---
>>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>>> index 1659b59fb5d7..e178f6f40e93 100644
>>>>>> --- a/security/selinux/hooks.c
>>>>>> +++ b/security/selinux/hooks.c
>>>>>> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct
>>>>>> inode *inode, struct inode *dir,
>>>>>> +
>>>>>> +     /*
>>>>>> +      * We shouldn't be creating secure anonymous inodes before LSM
>>>>>> +      * initialization completes.
>>>>>> +      */
>>>>>> +     if (unlikely(!selinux_state.initialized))
>>>>>> +             return -EBUSY;
>>>>>
>>>>> I don't think this is viable; any arbitrary actions are possible before
>>>>> policy is loaded, and a Linux distro can be brought up fully with
>>>>> SELinux enabled and no policy loaded.  You'll just need to have a
>>>>> default behavior prior to initialization.
>>>>
>>>> We'd have to fail open then, I think, and return an S_PRIVATE inode
>>>> (the regular anon inode).
>>>
>>> Not sure why.  You aren't doing anything in the hook that actually
>>> relies on selinux_state.initialized being set (i.e. nothing requires a
>>> policy).  The avc_has_perm() call will just succeed until a policy is
>>> loaded.  So if these inodes are created prior to policy load, they will
>>> get assigned the task SID (which would be the kernel SID prior to policy
>>> load or first exec or write to /proc/self/attr/current afterward) and
>>> UFFD class (in your current code), be permitted, and then once policy is
>>> loaded any further access will get checked against the kernel SID.
>>>
>>>>>> +     /*
>>>>>> +      * We only get here once per ephemeral inode.  The inode has
>>>>>> +      * been initialized via inode_alloc_security but is otherwise
>>>>>> +      * untouched, so check that the state is as
>>>>>> +      * inode_alloc_security left it.
>>>>>> +      */
>>>>>> +     BUG_ON(isec->initialized != LABEL_INVALID);
>>>>>> +     BUG_ON(isec->sclass != SECCLASS_FILE);
>>>>>
>>>>> I think the kernel discourages overuse of BUG_ON/BUG/...
>>>>
>>>> I'm not sure what counts as overuse.
>>>
>>> Me either (not my rule) but I'm pretty sure this counts or you'd see a
>>> lot more of these kinds of BUG_ON() checks throughout.  Try to reserve
>>> them for really critical cases.
>>>
>>>>>> +
>>>>>> +#ifdef CONFIG_USERFAULTFD
>>>>>> +     if (fops == &userfaultfd_fops)
>>>>>> +             isec->sclass = SECCLASS_UFFD;
>>>>>> +#endif
>>>>>
>>>>> Not sure we want or need to introduce a new security class for each user
>>>>> of anonymous inodes since the permissions should be the same as for
>>>>> file.
>>>>
>>>> The purpose of this change is to apply special policy to userfaultfd
>>>> FDs in particular. Isn't having a UFFD security class the best way to
>>>> go about that? (There's no path.) Am I missing something?
>>>
>>> It is probably the simplest approach; it just doesn't generalize to all
>>> users of anonymous inodes. We can distinguish them in one of two ways:
>>> use a different class like you did (requires a code change every time we
>>> add a new one and yet another duplicate of the file class) or use a
>>> different SID/context/type. The latter could be achieved by calling
>>> security_transition_sid() with the provided name wrapped in a qstr and
>>> specifying type_transition rules on the name.  Then policy could define
>>> derived types for each domain, ala
>>> type_transition init self:file "[userfaultfd]" init_userfaultfd;
>>> type_transition untrusted_app self:file "[userfaultfd]"
>>> untrusted_app_userfaultfd;
>>> ...
>>>
>>>>> Also not sure we want to be testing fops for each such case.
>>>>
>>>> I was also thinking of just providing some kind of context string
>>>> (maybe the name), which might be friendlier to modules, but the loose
>>>> coupling kind of scares me, and for this particular application, since
>>>> UFFD is always in the core and never in a module, checking the fops
>>>> seems a bit more robust and doesn't hurt anything.
>>>
>>> Yes, not sure how the vfs folks feel about either coupling (the
>>> name-based one or the fops-based one).  Neither seems great.
>>>
>>>>> We
>>>>> were looking at possibly leveraging the name as a key and using
>>>>> security_transition_sid() to generate a distinct SID/context/type for
>>>>> the inode via type_transition rules in policy.  We have some WIP along
>>>>> those lines.
>>>>
>>>> Where? Any chance it would be ready soon? I'd rather not hold up this
>>>> work for a more general mechanism.
>>>
>>> Hopefully will have a patch available soon.  But not saying this
>>> necessarily has to wait either.
>>>
>>>>>> +     /*
>>>>>> +      * Always give secure anonymous inodes the sid of the
>>>>>> +      * creating task.
>>>>>> +      */
>>>>>> +
>>>>>> +     isec->sid = tsec->sid;
>>>>>
>>>>> This doesn't generalize for other users of anonymous inodes, e.g. the
>>>>> /dev/kvm case where we'd rather inherit the SID and class from the
>>>>> original /dev/kvm inode itself.
>>>>
>>>> I think someone mentioned on the first version of this patch that we
>>>> could make it more flexible if the need arose. If we do want to do it
>>>> now, we could have the anon_inode security hook accept a "parent" or
>>>> "context" inode that modules could inspect for the purposes of forming
>>>> the new inode's SID. Does that make sense to you?
>>>
>>> Yes, that's the approach in our current WIP, except we call it a
>>> "related" inode since it isn't necessarily connected to the anon inode
>>> in any vfs sense.
>>
>> The other key difference in our WIP approach is that we assumed that we
>> couldn't mandate allocating a separate anon inode for each of these fds
>> and we wanted to cover all anonymous inodes (not opt-in), so we are
>> storing the SID/class pair as additional fields in the
>> file_security_struct and have modified file_has_perm() and others to
>> look there for anonymous inodes.
> 
> A separate inode seems like the simpler approach for now, because it
> means that we have fewer places to check for security information ---
> and it's not as if an inode is particularly expensive. We can always
> switch later.

We'd prefer having a separate inode if possible but didn't think that 
would fly with the vfs folks, especially if we try to apply this to all 
anonymous inodes. It might be ok for userfaultfd usage as a specific 
case but there is a reason why anonymous inodes were introduced and 
creating a separate inode each time defeats that purpose IIUC.  It will 
be interesting to see how they respond.
