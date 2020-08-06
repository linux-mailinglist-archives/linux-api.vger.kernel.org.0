Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7823DD38
	for <lists+linux-api@lfdr.de>; Thu,  6 Aug 2020 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgHFRGM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Aug 2020 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgHFRFs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Aug 2020 13:05:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA1C0A8891
        for <linux-api@vger.kernel.org>; Thu,  6 Aug 2020 07:45:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i138so34718150ild.9
        for <linux-api@vger.kernel.org>; Thu, 06 Aug 2020 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4cJ9kP3/QwzZNthUtsOjhu6rTVF+wY/ZoFelfzu+s4=;
        b=enQ46/8UJpafoTUsx6GsvtfMUmNj8dZqxhKn+aekJLw24TGyQe/9DB4NMJrXz8Gn3X
         3b8hQW1zt5ezg94/dlUE4j8oCdS173qlNMiCdLG8K2BfsoCmfCERxTEOAhj42XxdGKgE
         KvwVkfS2Lessc5mXmUyz2vADfJJWRjk6rpTdhboV/e+8IVyqnK4vGqIkEib5X05o6zOm
         XgjdZY+T09eZ100PUl6LzLJBDftBKLDGrLi8+JgHNxwZw5Jtqxn1Hc2lsok+1FPDxJ9q
         E+NLTBSs3wkCkdi+G+CAXN+V36HZms5s1ZjpxEJIJ8Db9qlBcOXc7SldMjuo92CmNbn3
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4cJ9kP3/QwzZNthUtsOjhu6rTVF+wY/ZoFelfzu+s4=;
        b=FT84xwqVOqYvUFxyycyYvM1mKeTGk+5zpHtkFjRcwkjqrEcFYt6sSdRQAP/PdaQ9sx
         DY3pta+R6Y24LItBYssQMpCA5sXsyUp93BAlGHRp+BKGJL9rEqiLWO1YbmVrG/dQ5smF
         dgkzMRJP1SrWAOPWn/OYEmo4kWRSL5OCWSuhY+8LmOMBRgooJdncNNPXfLkxDdrvecMs
         NKhqlVY0+esxVtLgA1oR/xRMvsWzNuwXgG5a/2MCtnLlyPFp1lC7ea/5/FW4zTl7cJNh
         YGzv55xCAEIZ31aRWcBUMY86UX1EnCzZaGlU7V+B33cB6gvKhqGx5hLA5Uj06XSpiJOE
         1whg==
X-Gm-Message-State: AOAM532+sNJNiGzY2QCFKwfB/6v8yfdVwVNphe2zAIoTsI4bJTDec/WF
        PEcrEsbgL8KfXCqlisHS7Lw9DR69Ed7rmkjWo0IasA==
X-Google-Smtp-Source: ABdhPJwu/iLGRyqF0WyJN5ax5yp/CiX30nzRev10q3kB+HJmWGfUejCN7JqZDvohvLvyDAkwALRDLN5XJzctNqyJ27w=
X-Received: by 2002:a92:1805:: with SMTP id 5mr10588552ily.127.1596725099915;
 Thu, 06 Aug 2020 07:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200728163416.556521-1-hch@lst.de> <20200728163416.556521-3-hch@lst.de>
In-Reply-To: <20200728163416.556521-3-hch@lst.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Aug 2020 20:14:48 +0530
Message-ID: <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] fs: refactor ksys_umount
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        chrubis <chrubis@suse.cz>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 28 Jul 2020 at 22:04, Christoph Hellwig <hch@lst.de> wrote:
>
> Factor out a path_umount helper that takes a struct path * instead of the
> actual file name.  This will allow to convert the init and devtmpfs code
> to properly mount based on a kernel pointer instead of relying on the
> implicit set_fs(KERNEL_DS) during early init.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/namespace.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6f8234f74bed90..43834b59eff6c3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1706,36 +1706,19 @@ static inline bool may_mandlock(void)
>  }
>  #endif
>
> -/*
> - * Now umount can handle mount points as well as block devices.
> - * This is important for filesystems which use unnamed block devices.
> - *
> - * We now support a flag for forced unmount like the other 'big iron'
> - * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
> - */
> -
> -int ksys_umount(char __user *name, int flags)
> +static int path_umount(struct path *path, int flags)
>  {
> -       struct path path;
>         struct mount *mnt;
>         int retval;
> -       int lookup_flags = LOOKUP_MOUNTPOINT;
>
>         if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
>                 return -EINVAL;
> -
>         if (!may_mount())
>                 return -EPERM;
>
> -       if (!(flags & UMOUNT_NOFOLLOW))
> -               lookup_flags |= LOOKUP_FOLLOW;
> -
> -       retval = user_path_at(AT_FDCWD, name, lookup_flags, &path);
> -       if (retval)
> -               goto out;
> -       mnt = real_mount(path.mnt);
> +       mnt = real_mount(path->mnt);
>         retval = -EINVAL;
> -       if (path.dentry != path.mnt->mnt_root)
> +       if (path->dentry != path->mnt->mnt_root)
>                 goto dput_and_out;
>         if (!check_mnt(mnt))
>                 goto dput_and_out;
> @@ -1748,12 +1731,25 @@ int ksys_umount(char __user *name, int flags)
>         retval = do_umount(mnt, flags);
>  dput_and_out:
>         /* we mustn't call path_put() as that would clear mnt_expiry_mark */
> -       dput(path.dentry);
> +       dput(path->dentry);
>         mntput_no_expire(mnt);
> -out:
>         return retval;
>  }
>
> +int ksys_umount(char __user *name, int flags)
> +{
> +       int lookup_flags = LOOKUP_MOUNTPOINT;
> +       struct path path;
> +       int ret;
> +
> +       if (!(flags & UMOUNT_NOFOLLOW))
> +               lookup_flags |= LOOKUP_FOLLOW;
> +       ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
> +       if (ret)
> +               return ret;
> +       return path_umount(&path, flags);
> +}
> +
>  SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
>  {
>         return ksys_umount(name, flags);

Regressions on linux next 20200803 tag kernel.
LTP syscalls test umount03 mount a path for testing and
umount failed and retired for 50 times and test exit with warning
and following test cases using that mount path failed.

LTP syscalls tests failed list,
    * umount03
    * umount2_01
    * umount2_02
    * umount2_03
    * utime06
    * copy_file_range01


Summary
------------------------------------------------------------------------

kernel: 5.8.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git describe: next-20200803
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200803
------------------------------------------------------------------------

test failed log:
tst_device.c:262: INFO: Using test device LTP_DEV='/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.43.8 (1-Jan-2018)
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
[  870.449934] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
[  870.454338] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
[  870.456412] ext2 filesystem being mounted at
/tmp/ltp-YQrzWZNEEy/jVhqum/mntpoint supports timestamps until 2038
(0x7fffffff)
umount03.c:35: PASS: umount() fails as expected: EPERM (1)
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:388: INFO: Likely gvfsd-trash is probing newly mounted
fs, kill it to speed up tests.
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  3...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  4...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  5...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  6...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  7...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  8...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try  9...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 10...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 11...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 12...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 13...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 14...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 15...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 16...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 17...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 18...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 19...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 20...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 21...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 22...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 23...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 24...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 25...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 26...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 27...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 28...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 29...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 30...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 31...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 32...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 33...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 34...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 35...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 36...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 37...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 38...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 39...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 40...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 41...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 42...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 43...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 44...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 45...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 46...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 47...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 48...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:384: INFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:394: WARN: Failed to umount('mntpoint') after 50 retries
tst_tmpdir.c:337: WARN: tst_rmdir: rmobj(/tmp/ltp-YQrzWZNEEy/jVhqum)
failed: remove(/tmp/ltp-YQrzWZNEEy/jVhqum/mntpoint) failed; errno=16:
EBUSY
Summary:
passed   1
failed   0
skipped  0
warnings 1

mke2fs 1.43.8 (1-Jan-2018)
/dev/loop0 is mounted; will not make a filesystem here!
umount2_01    0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
umount2_01    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
umount2_01    1  TBROK  :  tst_mkfs.c:103: umount2_01.c:81: mkfs.ext2
failed with 1
umount2_01    2  TBROK  :  tst_mkfs.c:103: Remaining cases broken
mke2fs 1.43.8 (1-Jan-2018)
/dev/loop0 is mounted; will not make a filesystem here!
umount2_02    0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
umount2_02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
umount2_02    1  TBROK  :  tst_mkfs.c:103: umount2_02.c:121: mkfs.ext2
failed with 1
umount2_02    2  TBROK  :  tst_mkfs.c:103: Remaining cases broken
mke2fs 1.43.8 (1-Jan-2018)
/dev/loop0 is mounted; will not make a filesystem here!
umount2_03    0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
umount2_03    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
umount2_03    1  TBROK  :  tst_mkfs.c:103: umount2_03.c:101: mkfs.ext2
failed with 1
umount2_03    2  TBROK  :  tst_mkfs.c:103: Remaining cases broken

mke2fs 1.43.8 (1-Jan-2018)
/dev/loop0 is mounted; will not make a filesystem here!
utime06     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
utime06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
utime06     1  TBROK  :  tst_mkfs.c:103: utime06.c:122: mkfs.ext2 failed with 1
utime06     2  TBROK  :  tst_mkfs.c:103: Remaining cases broken

Steps to reproduce:
-------------------------
cd /opt/ltp
./runltp -s umount                 --> FAILS

Above command runs all umount tests.

Test case description,
Verify that umount(2) returns -1 and sets errno to EPERM if the user
is not the super-user.
Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/umount/umount03.c

full test log,
https://lkft.validation.linaro.org/scheduler/job/1642287

--
Linaro LKFT
https://lkft.linaro.org
