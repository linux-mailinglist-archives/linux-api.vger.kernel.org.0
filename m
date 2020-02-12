Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4715AF62
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLSD2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 13:03:28 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:56048 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLSD2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 13:03:28 -0500
X-EEMSG-check-017: 55572644|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="55572644"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 18:03:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581530605; x=1613066605;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CPSK5uvwAHL9zLU/mCOyKXBRi4gAZlReLRVsng8C0z8=;
  b=JhpqZmuw60h3nUuxI9q2hNnv0PlsjTTXkHROtP5MUPQdh/v4buFjCymM
   /6Snzd3S80snoSyotF4gMawH1/I0RiWAkCxBojiIEr+XdtoNPKgFkhBGr
   H4ieWmWHxFmruSksBRmtEQ9s8wDm5eCKeTIkfhZVYeSwOZHb+yT/gC08r
   9kKvHJUBxmz4Vv4o07ewRm3BIZl7DA5MTuKrE6X00i6VGHyeDb88Vshi8
   vaXTMfB7d4FqCUE4+8MlwwIT9Ypteg8kIm2AoNSd9zXMWiefjhLNUBgDd
   1ILi0TZegimNAT/WuvGpTKCYxLAlte7wlM7Tx1bJrK6pi1BkHP2pPzVNW
   g==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39029087"
IronPort-PHdr: =?us-ascii?q?9a23=3AFiMrCRXhMruNGAVV9IYnwdsBPlbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRaFtKdThVPEFb/W9+hDw7KP9fy5BSpevN3Y6CBKWacPfi?=
 =?us-ascii?q?FGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFjJ6sxxR?=
 =?us-ascii?q?fFv2dEdudLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4SaJXATE7OG?=
 =?us-ascii?q?0r58PlqAfOQxKX6nQTTmsZnBxIAxPY7B7hRZf+rjH6tutm1yaEO8D9UK05Vi?=
 =?us-ascii?q?6j76dvTx/olTsHOjsk+2zZlsB8kKRWqw+6qhdh34Dbfp2aNPtmfqPcY9waQ3?=
 =?us-ascii?q?ZBXt1MXCBFG4+wcpcDA/YEMeteoYb9vV8OpgagCweqCu3k1ztEimb40KA+1u?=
 =?us-ascii?q?gsFxzN0g49ENIUqHnascv7NKkSX+62wqfHwzrMYPFK1jny84XIbhIsrOuQUb?=
 =?us-ascii?q?5sf8fcy08iHB7FgFWKrozlOiuY2PkRs2eF9+pgVfygi2g6oA9spzig3MMsio?=
 =?us-ascii?q?3XiYMV11vJ8j55z5suJdCjVE56YcKrEJtXty2AMYt2WdktT3tnuCY91L0LoJ?=
 =?us-ascii?q?i2dzUJxpQ/3xPTdvOKfoeS7h/jSeqdOyl0iX17dL6lmhq/91WrxPfmWcmuyl?=
 =?us-ascii?q?lKqzJIktzLtn8QyRPe8tOHSv5h/ke53jaPyhzT5vlEIU8qkarbLIYswqIqmZ?=
 =?us-ascii?q?oJsETDAzT2lF/3jK+QeEUk/fOo5Pr7bbn8up+dN5N7igH5Mqg0nMywHf84PR?=
 =?us-ascii?q?QUU2ie+OS80KXv/Uz/QLpUkv07irTVvZ/VKMgBpqO1HhVZ3pgs5hqhFTuqzc?=
 =?us-ascii?q?wUnXwdI1JEfBKHgZLpO1bLIP3gFvewnk+snSx3x/HGIrLhApLNImLFkLf6Z7?=
 =?us-ascii?q?lx8UFcyA0tzdxH/ZJbFqkBIO7vWk/2rNHXEwU2MwqozObgDNVwzYweWWWIAq?=
 =?us-ascii?q?+WNKPdr0WE6f4oI+mJfIUVoiryK+A55/7yin80gUMdfais3ZsSdXC4BO5mLF?=
 =?us-ascii?q?+ZYHf3jdcBFmAKvgU6TOP0klGNTTlTZ3OqVaIm+j47EJ6mDZvERo21hryB2z?=
 =?us-ascii?q?y7Hp1Na2BJDVCMFnjod4GaVPsWdC2SJcphmCQeVbe9U48hyQ2utAjixrphKO?=
 =?us-ascii?q?rU+TYVtZ3k1Nhy6O3TkQ89+SZoAMSa1mGHV3t0kX8QRz8qwKB/plRwylOE0a?=
 =?us-ascii?q?h7nfNYDtxT5/xIUggnL57T1fd3C9/1WgLGcdeJTEipTs+6DjE2S9I728UObF?=
 =?us-ascii?q?plG9W+khDD2DKnA7sUl7yNGZw1/bvQ33vvKMZnzXbJyq0hgkI4QstAK2KmnL?=
 =?us-ascii?q?Rz9wvNCI7TlUWWiaKqeb4b3C7X+2eJ1XCOs11AUA5sTaXFWmgSZk/XrdT/+0?=
 =?us-ascii?q?PDQKaiBq4/MgtA0sOCNKRKZcPzjVlcR/fsJs7eY2SvlGe0HxqIwamMbIXycW?=
 =?us-ascii?q?UHwCrdEFQEkxwU/XueLggxGCOho2PYDDxzGlPieF3s8eZgp3OhVEM0zB+Fb1?=
 =?us-ascii?q?dn17Wr/h4Zn/ucS+kc3uFMhCB0hzxyHVu5l/nRD9ObrAtmeqgUNd805lxA0U?=
 =?us-ascii?q?rWsAtyOpHmJKdn0A0waQNy6njy2g13B4MIqs0jqHcn3UImMq6D+E9QfDOfm5?=
 =?us-ascii?q?brM/vYLXekr0PnULLfxlyLiIXewawI8vlt7gy47Qw=3D?=
X-IPAS-Result: =?us-ascii?q?A2CmAwB3PURe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFoBSASKoQUiQOGZAEBAQEBAQaBEiWJcJBzA1QJAQEBAQEBAQEBNwQBAYRAA?=
 =?us-ascii?q?oJtOBMCEAEBAQUBAQEBAQUDAQFshQsBBTKCOykBgwEBAQEBAgEjBBFBEAsOC?=
 =?us-ascii?q?gICJgICVwYKAwYCAQGCYz+CVwUgq091fzOFSoNGgT6BDiqMPnmBB4ERJwwDg?=
 =?us-ascii?q?V9QLj6HW4JeBJAchkVkRpdrgkSCT5N8BhyCSIgSBYRFi3GsJiI3gSErCAIYC?=
 =?us-ascii?q?CEPgydQGA2EVwGJUReOQSMDMJFhAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 18:03:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CI2P4J152921;
        Wed, 12 Feb 2020 13:02:25 -0500
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ae8adb92-9c6e-2318-a3b9-903ead3848b5@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 13:04:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/12/20 12:19 PM, Daniel Colascione wrote:
> Thanks for taking a look.
> 
> On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 2/11/20 5:55 PM, Daniel Colascione wrote:
>>> Use the secure anonymous inode LSM hook we just added to let SELinux
>>> policy place restrictions on userfaultfd use. The create operation
>>> applies to processes creating new instances of these file objects;
>>> transfer between processes is covered by restrictions on read, write,
>>> and ioctl access already checked inside selinux_file_receive.
>>>
>>> Signed-off-by: Daniel Colascione <dancol@google.com>
>>
>> (please add linux-fsdevel and viro to the cc for future versions of this
>> patch since it changes the VFS)
>>
>>> ---
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 1659b59fb5d7..e178f6f40e93 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>>> +
>>> +     /*
>>> +      * We shouldn't be creating secure anonymous inodes before LSM
>>> +      * initialization completes.
>>> +      */
>>> +     if (unlikely(!selinux_state.initialized))
>>> +             return -EBUSY;
>>
>> I don't think this is viable; any arbitrary actions are possible before
>> policy is loaded, and a Linux distro can be brought up fully with
>> SELinux enabled and no policy loaded.  You'll just need to have a
>> default behavior prior to initialization.
> 
> We'd have to fail open then, I think, and return an S_PRIVATE inode
> (the regular anon inode).

Not sure why.  You aren't doing anything in the hook that actually 
relies on selinux_state.initialized being set (i.e. nothing requires a 
policy).  The avc_has_perm() call will just succeed until a policy is 
loaded.  So if these inodes are created prior to policy load, they will 
get assigned the task SID (which would be the kernel SID prior to policy 
load or first exec or write to /proc/self/attr/current afterward) and 
UFFD class (in your current code), be permitted, and then once policy is 
loaded any further access will get checked against the kernel SID.

>>> +     /*
>>> +      * We only get here once per ephemeral inode.  The inode has
>>> +      * been initialized via inode_alloc_security but is otherwise
>>> +      * untouched, so check that the state is as
>>> +      * inode_alloc_security left it.
>>> +      */
>>> +     BUG_ON(isec->initialized != LABEL_INVALID);
>>> +     BUG_ON(isec->sclass != SECCLASS_FILE);
>>
>> I think the kernel discourages overuse of BUG_ON/BUG/...
> 
> I'm not sure what counts as overuse.

Me either (not my rule) but I'm pretty sure this counts or you'd see a 
lot more of these kinds of BUG_ON() checks throughout.  Try to reserve 
them for really critical cases.

>>> +
>>> +#ifdef CONFIG_USERFAULTFD
>>> +     if (fops == &userfaultfd_fops)
>>> +             isec->sclass = SECCLASS_UFFD;
>>> +#endif
>>
>> Not sure we want or need to introduce a new security class for each user
>> of anonymous inodes since the permissions should be the same as for
>> file.
> 
> The purpose of this change is to apply special policy to userfaultfd
> FDs in particular. Isn't having a UFFD security class the best way to
> go about that? (There's no path.) Am I missing something?

It is probably the simplest approach; it just doesn't generalize to all 
users of anonymous inodes. We can distinguish them in one of two ways: 
use a different class like you did (requires a code change every time we 
add a new one and yet another duplicate of the file class) or use a 
different SID/context/type. The latter could be achieved by calling 
security_transition_sid() with the provided name wrapped in a qstr and 
specifying type_transition rules on the name.  Then policy could define 
derived types for each domain, ala
type_transition init self:file "[userfaultfd]" init_userfaultfd;
type_transition untrusted_app self:file "[userfaultfd]" 
untrusted_app_userfaultfd;
...

>> Also not sure we want to be testing fops for each such case.
> 
> I was also thinking of just providing some kind of context string
> (maybe the name), which might be friendlier to modules, but the loose
> coupling kind of scares me, and for this particular application, since
> UFFD is always in the core and never in a module, checking the fops
> seems a bit more robust and doesn't hurt anything.

Yes, not sure how the vfs folks feel about either coupling (the 
name-based one or the fops-based one).  Neither seems great.

>> We
>> were looking at possibly leveraging the name as a key and using
>> security_transition_sid() to generate a distinct SID/context/type for
>> the inode via type_transition rules in policy.  We have some WIP along
>> those lines.
> 
> Where? Any chance it would be ready soon? I'd rather not hold up this
> work for a more general mechanism.

Hopefully will have a patch available soon.  But not saying this 
necessarily has to wait either.

>>> +     /*
>>> +      * Always give secure anonymous inodes the sid of the
>>> +      * creating task.
>>> +      */
>>> +
>>> +     isec->sid = tsec->sid;
>>
>> This doesn't generalize for other users of anonymous inodes, e.g. the
>> /dev/kvm case where we'd rather inherit the SID and class from the
>> original /dev/kvm inode itself.
> 
> I think someone mentioned on the first version of this patch that we
> could make it more flexible if the need arose. If we do want to do it
> now, we could have the anon_inode security hook accept a "parent" or
> "context" inode that modules could inspect for the purposes of forming
> the new inode's SID. Does that make sense to you?

Yes, that's the approach in our current WIP, except we call it a 
"related" inode since it isn't necessarily connected to the anon inode 
in any vfs sense.
