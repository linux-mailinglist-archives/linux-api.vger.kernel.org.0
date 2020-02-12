Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCF15ADFF
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBLREj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 12:04:39 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:59993 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLREj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 12:04:39 -0500
X-EEMSG-check-017: 58189367|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="58189367"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 17:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581527075; x=1613063075;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=zKp7U0pFTqFM/FgNluPbvsZXi8mhH1PMiDNjsoIC9oU=;
  b=TBT8+NaloQ+lHEc2oW5+lmie5efNkEGMyZMV6fayso8VjLiuYIMdwZ7T
   9Ej9fhspWaih2+zFQxEgu6fgapv6FZau1/BCLAFk4s6FIZSHBkyKvPp3x
   FOSKVLG4LZ06noA+nSP1E8E7TYXlV7j1BIv++e16/Wu5PfiPai5ehTr5S
   bCNJov2rWnfnoiv9QmGzbyVF23yqAGssHEO8sIgUg5xt1Ha0uANgyerZF
   XPVVRiEPavbdOxTwi9AUhbzcQvjzafjO1sPN5x2AmOwIP25aD8UiGGzvC
   epvzRxmWL319idzLoxnj7JisXg+x0ASHOk4vqJqSzi5m+2cVI/1VQUCL4
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39022781"
IronPort-PHdr: =?us-ascii?q?9a23=3Ah0m23BwvIYbAiafXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukeLfad9pjvdHbS+e9qxAeQG9mCt7Qa1qGH7ujJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+NhS7oAXeusQSgYZpN7o8xA?=
 =?us-ascii?q?bOrnZUdOtawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opJBb4bJvL8RkjxtNjDAx82NAy0xOnnCNFj2Y8ERW2PBa?=
 =?us-ascii?q?qZOrvIsVCU/uIvP/WMZIgNtTbhKvgl4vvujWIjmV8HZ6ao3YAaaH+/HvRhLE?=
 =?us-ascii?q?WZZWTjjs0dHmcNuwo0VPbqh0GaUT5Pe3ayWLox5jc8CIK9DYfOXY+tgLuG3C?=
 =?us-ascii?q?e0Gp1ZeHpKBUyLEXftb4+EQesDaDqOIs99lTwJTb6hS4ki1Ry1uw/6zL1nLu?=
 =?us-ascii?q?XQ+iIGr57syN915+jLnxEo6TN0F9id032KT2xsmmMIQDw2075koUx9xVeD0L?=
 =?us-ascii?q?V3g+ZCGtFI6PNJVQA6NZHYz+NkEdz9RgXBftKRQla8XtqmGS0xTs42w9IWZ0?=
 =?us-ascii?q?Z9GtOijg3M3iazAL8aiaaLBJoq/aLYxHXxOcl9xGjc1KU7jFkpXNFPNWu4ia?=
 =?us-ascii?q?577QTTAJTJk0qBnaawaascxDLN9HuEzWeWuEFYUQhwUbjKXHwGfETWtdX561?=
 =?us-ascii?q?jcT7+hF7snKBFNyc2cJatQbN3mk1FGSO3kONTEbGK7g32wCgqQxrOQcIrqfH?=
 =?us-ascii?q?0Q3D7DB0gAkgAT+2uGNAclCye/rGLREiZuGUjsY0zy6+l+rm20TksuwwGNdU?=
 =?us-ascii?q?1h2On9xhlAqfWaSv4XlpkDvC46oDRzGlv1i97fDdGHoyJue6JTZd5761BCgy?=
 =?us-ascii?q?aRqw14O4G6NalzrlEZdAtzsgXl0BAzQoNHisgCo3Qtww5/b6mf1RcJcTWb9Z?=
 =?us-ascii?q?/3PbLTJy/5+xXrI6rR2VzF0NmX9r0GwPs/rFrnsUeiEU9mu3Fm1cRFlniR/J?=
 =?us-ascii?q?PHCCIMXp/rFEU67R53o/fdeCZ5r4fV02B8dKCssxfc1N8zQugo0BCte5FYKq?=
 =?us-ascii?q?zAXBT/F8wcGtiGNuMngR6qYwgCMeQU87Q7bO28cP7T47KmJOZtmnqdiG1D5I?=
 =?us-ascii?q?1smhaX+zFUVv/D35FDxeqRmASASWGv3x+arsnrlNUcNnkpFW2lxH2hXdUAaw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CIAgBCL0Re/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZlAQEBAQEBBoE3iXCQcwNUCQEBAQEBAQEBATcEAQGEQAKCb?=
 =?us-ascii?q?TgTAhABAQEFAQEBAQEFAwEBbIVDgjspAYMCAQUjBBFRCw4KAgImAgJXBgEJA?=
 =?us-ascii?q?wYCAQGCYz+CVyWsEX8zhUqDRYE+gQ4qjD55gQeBOA+CLy4+h1uCXgSWYWRGl?=
 =?us-ascii?q?2uCRIJPk3wGHIJIiBIFhEWLcY5onT4iN4EhKwgCGAghD4MnUBgNjikXjkEjA?=
 =?us-ascii?q?zCRYQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 17:04:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CH3ZOp127896;
        Wed, 12 Feb 2020 12:03:35 -0500
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        nosh@google.com, nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200211225547.235083-1-dancol@google.com>
 <20200211225547.235083-4-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 12:05:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211225547.235083-4-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/11/20 5:55 PM, Daniel Colascione wrote:
> Use the secure anonymous inode LSM hook we just added to let SELinux
> policy place restrictions on userfaultfd use. The create operation
> applies to processes creating new instances of these file objects;
> transfer between processes is covered by restrictions on read, write,
> and ioctl access already checked inside selinux_file_receive.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

(please add linux-fsdevel and viro to the cc for future versions of this 
patch since it changes the VFS)

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1659b59fb5d7..e178f6f40e93 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   	return 0;
>   }
>   
> +static int selinux_inode_init_security_anon(struct inode *inode,
> +					    const char *name,
> +					    const struct file_operations *fops)
> +{
> +	const struct task_security_struct *tsec = selinux_cred(current_cred());
> +	struct common_audit_data ad;
> +	struct inode_security_struct *isec;
> +
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return 0;

Seems like this is precluded by the caller and would be a bug?  If 
needed at all, take it to the security_inode_init_security_anon() so it 
doesn't have to be repeated in each security module.

> +
> +	/*
> +	 * We shouldn't be creating secure anonymous inodes before LSM
> +	 * initialization completes.
> +	 */
> +	if (unlikely(!selinux_state.initialized))
> +		return -EBUSY;

I don't think this is viable; any arbitrary actions are possible before 
policy is loaded, and a Linux distro can be brought up fully with 
SELinux enabled and no policy loaded.  You'll just need to have a 
default behavior prior to initialization.

> +
> +	isec = selinux_inode(inode);
> +
> +	/*
> +	 * We only get here once per ephemeral inode.  The inode has
> +	 * been initialized via inode_alloc_security but is otherwise
> +	 * untouched, so check that the state is as
> +	 * inode_alloc_security left it.
> +	 */
> +	BUG_ON(isec->initialized != LABEL_INVALID);
> +	BUG_ON(isec->sclass != SECCLASS_FILE);

I think the kernel discourages overuse of BUG_ON/BUG/...

> +
> +#ifdef CONFIG_USERFAULTFD
> +	if (fops == &userfaultfd_fops)
> +		isec->sclass = SECCLASS_UFFD;
> +#endif

Not sure we want or need to introduce a new security class for each user 
of anonymous inodes since the permissions should be the same as for 
file.  Also not sure we want to be testing fops for each such case.  We 
were looking at possibly leveraging the name as a key and using 
security_transition_sid() to generate a distinct SID/context/type for 
the inode via type_transition rules in policy.  We have some WIP along 
those lines.

> +
> +	if (isec->sclass == SECCLASS_FILE) {
> +		printk(KERN_WARNING "refusing to create secure anonymous inode "
> +		       "of unknown type");
> +		return -EOPNOTSUPP;
> +	}
> +	/*
> +	 * Always give secure anonymous inodes the sid of the
> +	 * creating task.
> +	 */
> +
> +	isec->sid = tsec->sid;

This doesn't generalize for other users of anonymous inodes, e.g. the 
/dev/kvm case where we'd rather inherit the SID and class from the 
original /dev/kvm inode itself.
