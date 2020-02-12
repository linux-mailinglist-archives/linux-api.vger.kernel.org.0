Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB615AD98
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBLQnh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 11:43:37 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:5949 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLQnh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 11:43:37 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 11:43:36 EST
X-EEMSG-check-017: 55389972|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="55389972"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 16:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581525386; x=1613061386;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=dGCMDfsKmGrlFlNJBg2rwo75WopPAbuNo6kwiTDcoLM=;
  b=QujyKR1RD14xM+SW94xoq+aeSHvnUwkre8pCMnFuPHS/9FKVgIoyj4Zi
   SMo676P/dn1q7mB6kTj78Vlfe1PHfaZFed48zoflTIhedvVwtppr3hfjy
   KSsDR49Pf3rB8YF0HfoCJtGf3dExOhD6pxq2YRCr954/cQJU4Q+Mx7TED
   MI5pMVKRrok4ZPbiiKh8kkLVGj6TtK6KH7UxgTJh4O6qMNCMD4C8IsfRg
   jC2kGckZdtDGR6dgGCukKf+AH++rmeG5cHUTK543LLlJlQaPizAGdQ1dc
   nLVkhbD9G88AZyxDLXpECJFBy2AhYBj01WAvX7LVrQaznXJtMBbaoJdu6
   A==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39019811"
IronPort-PHdr: =?us-ascii?q?9a23=3A/thMbxJTgyoff2skGtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKfT8rarrMEGX3/hxlliBBdydt6sYzbSL+PG4EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctsYajI9+Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqwOL+j1WkDts9zYCgQ0MwOzw+bgB9V90p0RVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wK+Qk5/7riH85hEUdfbOz0poXc324EfNmI0?=
 =?us-ascii?q?KWYXronNgNC3sFvg07TObykl2NTSZTZ2quX6I7/jw7DoWmDZzDRo22j7yB2y?=
 =?us-ascii?q?C7HpJSZm9YEFyDDXDod4CcUfcWdC2SOtNhkiADVbW5TY8h0xKuuRT1y7pgKe?=
 =?us-ascii?q?rU9SkYuoz52Ndp4O3TkAk49SZoAMSFz2GNU2Z0k3sMRz8x36Bwv1d9yleM0a?=
 =?us-ascii?q?h5nvNYD8Zc6uhGUgc9Mp7cwOh6BM7oVg3dedeJTU6sQs+6DjEpUtIx39gObl?=
 =?us-ascii?q?55G9WjiBDDwiWrD6YWl7OVHpw09LzT33zqKsZjxHbJyrMhg0MlQsRRL22mgL?=
 =?us-ascii?q?Bw9wzJC47OiUWZmL6gdb4A0y7V6GeD0W2OsVlcUA5xV6XFQH8ealLMotTh50?=
 =?us-ascii?q?PPVKGuCbs5PQtb08KCKbVFasfvjVpYQPfvItPeY3i+m22oHxaH2quMbJb2e2?=
 =?us-ascii?q?UaxCjdE1YLkwQS/XaAKAg/CTyso3zRDDNwD1LjeUDs/vdkqHO9UEA0yxuGb0?=
 =?us-ascii?q?p717q6qVYpgqmwQvUS07ZMkyAloi5/HVG70pqCB9OGrA1lVKpbZtw57RFM0m?=
 =?us-ascii?q?eP80RhP5mlMrp4j082fANwsEfjkR5wD8EIl88xrFslyw19La/e21REM3ue25?=
 =?us-ascii?q?PYNbrQJW3/uhuobuqe3lbd3c2W9aYD8v0QpFLkswWkUEEl9jEv19hTzmvZ5Z?=
 =?us-ascii?q?jQCgcWeYz+X1xx9BVgobzeJC4n6Mec0XxqLLnxuyfD88wmCfFjyRu6edpbdq?=
 =?us-ascii?q?SeG0u6CMAeBs6zOMQ0lFWzKBEJJuZf8OgzJcz1WeGB3fuQIOt4nD+gxV9C6Y?=
 =?us-ascii?q?R531PEozFwUcbUzp0FxLeexQLBWDDi2gTy+vvrkJxJMGlBVlG0zjLpUcsIPf?=
 =?us-ascii?q?x/?=
X-IPAS-Result: =?us-ascii?q?A2DEBABoKERe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBbSASKoQUiQOGZAEBAQEBAQaBN4lwkHMDVAkBAQEBAQEBAQE3BAEBhEACg?=
 =?us-ascii?q?m04EwIQAQEBBQEBAQEBBQMBAWyFQ0IWAYFiKQGDAgEFIwQRUQsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCYz+CVyWsAn8zg0yBfoNAgT6BDioBjD15gQeBOA+CKDU+h1uCX?=
 =?us-ascii?q?gSNYoh/ZEaXa4JEgk+KRok2BhyCSIgSBZA2jmidPiI3gSErCAIYCCEPgydQG?=
 =?us-ascii?q?A2OKReOQSMDMI4Ig1kBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 16:36:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CGZRS0109004;
        Wed, 12 Feb 2020 11:35:27 -0500
Subject: Re: [PATCH v2 1/6] Add a new flags-accepting interface for anonymous
 inodes
To:     Daniel Colascione <dancol@google.com>, timmurray@google.com,
        nosh@google.com, nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200211225547.235083-1-dancol@google.com>
 <20200211225547.235083-2-dancol@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <88ea16bd-38be-b4f9-dfb3-e0626f5b6aaf@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 11:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211225547.235083-2-dancol@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/11/20 5:55 PM, Daniel Colascione wrote:
> Add functions forwarding from the old names to the new ones so we
> don't need to change any callers.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

(please add linux-fsdevel, viro to cc on future versions of this patch 
since this is a VFS change)

> ---
>   fs/anon_inodes.c            | 62 ++++++++++++++++++++++---------------
>   include/linux/anon_inodes.h | 27 +++++++++++++---
>   2 files changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 89714308c25b..caa36019afca 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -56,60 +56,71 @@ static struct file_system_type anon_inode_fs_type = {
>   };
>   
>   /**
> - * anon_inode_getfile - creates a new file instance by hooking it up to an
> - *                      anonymous inode, and a dentry that describe the "class"
> - *                      of the file
> + * anon_inode_getfile2 - creates a new file instance by hooking it up to
> + *                       an anonymous inode, and a dentry that describe
> + *                       the "class" of the file

Not going to bikeshed on names but anon_inode_getfile_flags or _secure 
or something would be more descriptive.

>    *
>    * @name:    [in]    name of the "class" of the new file
>    * @fops:    [in]    file operations for the new file
>    * @priv:    [in]    private data for the new file (will be file's private_data)
> - * @flags:   [in]    flags
> + * @flags:   [in]    flags for the file
> + * @anon_inode_flags: [in] flags for anon_inode*

Do we really envision ever needing more than one new flag here?  If not, 
then making it a bool secure parameter or encoding it as an 
unused/ignored flag bit in the existing flags argument would seem 
preferable.

In some cases, we actually want the "anon inode" to inherit the security 
context of a related inode (e.g. ioctls on /dev/kvm can create anon 
inodes representing VMs, vCPUs, etc and further ioctls are performed on 
those inodes), in which case we may need the caller to pass in the 
related inode as well.

>    *
> - * Creates a new file by hooking it on a single inode. This is useful for files
> + * Creates a new file by hooking it on an unspecified inode. This is useful for files
>    * that do not need to have a full-fledged inode in order to operate correctly.
>    * All the files created with anon_inode_getfile() will share a single inode,
>    * hence saving memory and avoiding code duplication for the file/inode/dentry
>    * setup.  Returns the newly created file* or an error pointer.
> + *
> + * anon_inode_flags must be zero.
>    */
> -struct file *anon_inode_getfile(const char *name,
> -				const struct file_operations *fops,
> -				void *priv, int flags)
> +struct file *anon_inode_getfile2(const char *name,
> +				 const struct file_operations *fops,
> +				 void *priv, int flags, int anon_inode_flags)
>   {
> +	struct inode *inode;
>   	struct file *file;
>   
> -	if (IS_ERR(anon_inode_inode))
> -		return ERR_PTR(-ENODEV);
> -
> -	if (fops->owner && !try_module_get(fops->owner))
> -		return ERR_PTR(-ENOENT);
> +	if (anon_inode_flags)
> +		return ERR_PTR(-EINVAL);

Not sure this is how it is normally done (i.e. one patch to just 
introduce an extended interface but disallow all use of it, then a 
separate patch to introduce the first use).  Would recommend combining; 
otherwise reviewers can't see how it will be used without looking at both.
