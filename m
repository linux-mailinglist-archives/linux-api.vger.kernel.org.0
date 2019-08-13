Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84F8AF53
	for <lists+linux-api@lfdr.de>; Tue, 13 Aug 2019 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfHMGK6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Aug 2019 02:10:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48913 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfHMGK5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Aug 2019 02:10:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813061055euoutp02d87aa927ba3a9f5cacdf48396075ed54~6Zp9pS6801558915589euoutp02P
        for <linux-api@vger.kernel.org>; Tue, 13 Aug 2019 06:10:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813061055euoutp02d87aa927ba3a9f5cacdf48396075ed54~6Zp9pS6801558915589euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565676655;
        bh=Ouf2d6oH+wfg0RpGCYzzieijSZGWquinOBWw3nWjNy0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QE+pgJSlzkZNw9sP+vghOf8Ktz9oearU2RHA5QsvgrqR0HwB3jl9rVOs7WZ7NysXJ
         s2fmW22lBewB9J9dgOsoKq16PWI0NT2jrn43sTxKr+JDmpHObmQGIQvd5l8sUORrwE
         z/DfUM5k8rG6e5gSWL+QanHtuxMLcQoKSdHQlN20=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190813061054eucas1p163e140f33e91ef27f2b2d69fd85e5600~6Zp8iVmjs0307803078eucas1p1-;
        Tue, 13 Aug 2019 06:10:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.00.04309.D64525D5; Tue, 13
        Aug 2019 07:10:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813061053eucas1p1b6945259d9663b743e7cb32521d041e7~6Zp71YGPa0207202072eucas1p1F;
        Tue, 13 Aug 2019 06:10:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813061053eusmtrp2b4de50bbc680b89fe6fbcde4e3e39d02~6Zp7nQs-i1461014610eusmtrp2a;
        Tue, 13 Aug 2019 06:10:53 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-8f-5d52546dfb95
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.18.04117.D64525D5; Tue, 13
        Aug 2019 07:10:53 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813061052eusmtip2c732d81f8fdf476543006a8a87ba53f1~6Zp7LCuR62679326793eusmtip2X;
        Tue, 13 Aug 2019 06:10:52 +0000 (GMT)
Subject: Re: [PATCH V37 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a3caa6d3-e3f9-ae41-d87e-253d9dc53d81@samsung.com>
Date:   Tue, 13 Aug 2019 08:10:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731221617.234725-28-matthewgarrett@google.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87q5IUGxBodeGVmsW7+YyeL8+Q3s
        Fpu/d7BZXN41h83iQ88jNotXL7Qs/m14w2Kxr+MBkwOHR8u+W+weCzaVemxa1cnm0fM92ePz
        JrkA1igum5TUnMyy1CJ9uwSujFttO1kK1hhXdE+bwd7A+EWzi5GTQ0LAROLHhalsXYxcHEIC
        KxglNj/sZ4FwvjBKHNp+hxnC+cwocf5ACxtMy5FZK1ghEssZJRr+foWqessosffZInaQKmGB
        SImlGx6xgNgiAk4Sp/bfZAQpYha4ziixe9ELsFFsAoYSXW+7wGxeATuJi0tvs4LYLAKqEnNf
        PGUCsUUFYiR2vulhhqgRlDg58wnYUE4BR4m1j1rBapgF5CWat85mhrDFJW49mc8EskxCYBO7
        RPfsO+wQd7tIHN3cAfWDsMSr41ug4jIS/3fCNDQzSjw8t5YdwulhlLjcNIMRospa4vDxi0Dn
        cQCt0JRYv0sfIuwo8fH3TTaQsIQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9c
        Yp7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYjE7/
        O/5lB+OuP0mHGAU4GJV4eCsSAmOFWBPLiitzDzFKcDArifBeMgmKFeJNSaysSi3Kjy8qzUkt
        PsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cBYITD/Nbt0xNqZF1KdbQq7o1PK5I3T
        ymW6bF2jQswz5ENEhSf1Hn+u/HRTccVJ7dgdhZNk3ZX8Sx6fvXDnp/tCB9nzrUz/nzk+EufI
        s1I/f7p1Zk25YDqrhmdT7vX/eqYdgiGTl81xOds96fHJpE0X//k+PLNS22DyLIVdjpML1Rz8
        T0zgqlBiKc5INNRiLipOBACWF/XcQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7q5IUGxBi2LWC3WrV/MZHH+/AZ2
        i83fO9gsLu+aw2bxoecRm8WrF1oW/za8YbHY1/GAyYHDo2XfLXaPBZtKPTat6mTz6Pme7PF5
        k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJe
        xq22nSwFa4wruqfNYG9g/KLZxcjJISFgInFk1grWLkYuDiGBpYwSV69eYoNIyEicnNbACmEL
        S/y51gUWFxJ4zShxt7ESxBYWiJRYuuERC4gtIuAkcWr/TUaQQcwC1xklumZsYIJoKJPY+fQY
        mM0mYCjR9RZiEK+AncTFpbfBFrAIqErMffEUrEZUIEZi35nt7BA1ghInZz4BW8Ap4Cix9lEr
        WA2zgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz23
        2EivODG3uDQvXS85P3cTIzDyth37uWUHY9e74EOMAhyMSjy8FQmBsUKsiWXFlbmHGCU4mJVE
        eC+ZBMUK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wKeSVxBuaGppbWBqaG5sbm1koifN2
        CByMERJITyxJzU5NLUgtgulj4uCUamDc4BgXsW7Ll1mKV99ev/XtscCTpM0pNx9rXk89zer8
        b2Klz2GZqhY21WV6R5XO5dx7LZafVfjux8rL5lEm+2Vi2Zxs+tIVmbfFROt8nTrd6fjjjwqf
        G6cLcmkbxdqqO7MsMkraIhuWLHgq8MGLiyW6Eap7p3du3TM3ge3aSWaGzk2Xv+/kelKlxFKc
        kWioxVxUnAgASEfwm9ICAAA=
X-CMS-MailID: 20190813061053eucas1p1b6945259d9663b743e7cb32521d041e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813061053eucas1p1b6945259d9663b743e7cb32521d041e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813061053eucas1p1b6945259d9663b743e7cb32521d041e7
References: <20190731221617.234725-1-matthewgarrett@google.com>
        <20190731221617.234725-28-matthewgarrett@google.com>
        <CGME20190813061053eucas1p1b6945259d9663b743e7cb32521d041e7@eucas1p1.samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi

On 2019-08-01 00:16, Matthew Garrett wrote:
> Tracefs may release more information about the kernel than desirable, so
> restrict it when the kernel is locked down in confidentiality mode by
> preventing open().
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This patch causes the following regression on various Samsung Exynos SoC 
based boards (ARM 32bit):

[   15.364422] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[   15.368775] pgd = a530ddbe
[   15.371447] [00000000] *pgd=bcd7c831
[   15.374993] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
[   15.380890] Modules linked in:
[   15.383929] CPU: 0 PID: 1393 Comm: perf Not tainted 
5.2.0-00027-g757ff7244358-dirty #6459
[   15.392086] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   15.398164] PC is at 0x0
[   15.400687] LR is at do_dentry_open+0x22c/0x3b0
[   15.405193] pc : [<00000000>]    lr : [<c02977c4>]    psr: 60000053
[   15.411442] sp : e7317dd8  ip : 00000000  fp : 00000000
[   15.416650] r10: c0187e6c  r9 : c041f8cc  r8 : e72123c8
[   15.421858] r7 : e7317ec0  r6 : e7d89630  r5 : 00000000  r4 : e72123c0
[   15.428368] r3 : 00000000  r2 : 5ba370f3  r1 : e72123c0  r0 : e7d89630
[   15.434880] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  
Segment none
[   15.442083] Control: 10c5387d  Table: 6726404a  DAC: 00000051
[   15.447812] Process perf (pid: 1393, stack limit = 0x17621431)
[   15.453628] Stack: (0xe7317dd8 to 0xe7318000)
...
[   15.604842] [<c02977c4>] (do_dentry_open) from [<c02aafc8>] 
(path_openat+0x5a0/0x1004)
[   15.612735] [<c02aafc8>] (path_openat) from [<c02acce8>] 
(do_filp_open+0x6c/0xd8)
[   15.620200] [<c02acce8>] (do_filp_open) from [<c0298cc4>] 
(do_sys_open+0x130/0x1f4)
[   15.627839] [<c0298cc4>] (do_sys_open) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[   15.635560] Exception stack(0xe7317fa8 to 0xe7317ff0)
[   15.640596] 7fa0:                   0022dc0b 001deee0 ffffff9c 
beb6d764 00020000 00000000
[   15.648756] 7fc0: 0022dc0b 001deee0 0022dba8 00000142 001ba044 
00241d68 001a13d8 beb6e78c
[   15.656913] 7fe0: b6f7e000 beb6c6f8 9a27c600 b6f69504
[   15.661952] Code: bad PC value
[   15.665105] ---[ end trace 7e8b864582108f4a ]---

This is standard ARM 32bit kernel with 
arch/arm/configs/exynos_defconfig. It is enough to run "perf list" command.

> ---
>   fs/tracefs/inode.c           | 40 +++++++++++++++++++++++++++++++++++-
>   include/linux/security.h     |  1 +
>   security/lockdown/lockdown.c |  1 +
>   3 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 1387bcd96a79..12a325fb4cbd 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -21,6 +21,7 @@
>   #include <linux/seq_file.h>
>   #include <linux/magic.h>
>   #include <linux/slab.h>
> +#include <linux/security.h>
>   
>   #define TRACEFS_DEFAULT_MODE	0700
>   
> @@ -28,6 +29,23 @@ static struct vfsmount *tracefs_mount;
>   static int tracefs_mount_count;
>   static bool tracefs_registered;
>   
> +static int default_open_file(struct inode *inode, struct file *filp)
> +{
> +	struct dentry *dentry = filp->f_path.dentry;
> +	struct file_operations *real_fops;
> +	int ret;
> +
> +	if (!dentry)
> +		return -EINVAL;
> +
> +	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	if (ret)
> +		return ret;
> +
> +	real_fops = dentry->d_fsdata;

real_fops are NULL in my test case.

> +	return real_fops->open(inode, filp);
> +}
> +
>   static ssize_t default_read_file(struct file *file, char __user *buf,
>   				 size_t count, loff_t *ppos)
>   {
> @@ -210,6 +228,12 @@ static int tracefs_apply_options(struct super_block *sb)
>   	return 0;
>   }
>   
> +static void tracefs_destroy_inode(struct inode *inode)
> +{
> +	if (S_ISREG(inode->i_mode))
> +		kfree(inode->i_fop);
> +}
> +
>   static int tracefs_reconfigure(struct fs_context *fc)
>   {
>   	struct super_block *sb = fc->root->d_sb;
> @@ -236,6 +260,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
>   
>   static const struct super_operations tracefs_super_operations = {
>   	.statfs		= simple_statfs,
> +	.destroy_inode  = tracefs_destroy_inode,
>   	.show_options	= tracefs_show_options,
>   };
>   
> @@ -372,6 +397,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>   				   struct dentry *parent, void *data,
>   				   const struct file_operations *fops)
>   {
> +	struct file_operations *proxy_fops;
>   	struct dentry *dentry;
>   	struct inode *inode;
>   
> @@ -387,8 +413,20 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>   	if (unlikely(!inode))
>   		return failed_creating(dentry);
>   
> +	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
> +	if (unlikely(!proxy_fops)) {
> +		iput(inode);
> +		return failed_creating(dentry);
> +	}
> +
> +	if (!fops)
> +		fops = &tracefs_file_operations;
> +
> +	dentry->d_fsdata = (void *)fops;
> +	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
> +	proxy_fops->open = default_open_file;
>   	inode->i_mode = mode;
> -	inode->i_fop = fops ? fops : &tracefs_file_operations;
> +	inode->i_fop = proxy_fops;
>   	inode->i_private = data;
>   	d_instantiate(dentry, inode);
>   	fsnotify_create(dentry->d_parent->d_inode, dentry);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d92323b44a3f..807dc0d24982 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -121,6 +121,7 @@ enum lockdown_reason {
>   	LOCKDOWN_KPROBES,
>   	LOCKDOWN_BPF_READ,
>   	LOCKDOWN_PERF,
> +	LOCKDOWN_TRACEFS,
>   	LOCKDOWN_CONFIDENTIALITY_MAX,
>   };
>   
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 88064ce1c844..173191562047 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -36,6 +36,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>   	[LOCKDOWN_KPROBES] = "use of kprobes",
>   	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
>   	[LOCKDOWN_PERF] = "unsafe use of perf",
> +	[LOCKDOWN_TRACEFS] = "use of tracefs",
>   	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

