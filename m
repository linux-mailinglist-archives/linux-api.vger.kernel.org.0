Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDD3B3FAB
	for <lists+linux-api@lfdr.de>; Fri, 25 Jun 2021 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFYIqo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Jun 2021 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIqn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Jun 2021 04:46:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D08C061574
        for <linux-api@vger.kernel.org>; Fri, 25 Jun 2021 01:44:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so10603587oiv.1
        for <linux-api@vger.kernel.org>; Fri, 25 Jun 2021 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/SNZLNO26PNKy5JajQ9PAFY1DpOH8yI8w3OOoE88vLs=;
        b=zwCafeEKWK6uvQOetOtTfUec/V20BMFjV3YhA+Gs5xaSGZw8pDEY/SNDvamEtErpBA
         Mm5RJTQJrYX/tw8UJtS60wZMUcC30y9SnENWz9SiGi180JD+r6oCUa9FXGqkqL/HgC7N
         3vdZNbluSmQbDtKSjkjbcg7NB/Nn5j+wRrprRcf+DQ5hTxb8pmfItO5E8Dj9Pi92Ru0x
         DQFhTGSLyifOPZHjXxyvfopmsPLRKMJITbV898J7wWf0/WcUK3LbG137k4bH6UWr4LZb
         h9CvgWhZw2lD9ap/fcfo4wp0DJLgOlkl+/DRyz1Zit+NpSvlJIat5wskroWbqyz1Rd8j
         5GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/SNZLNO26PNKy5JajQ9PAFY1DpOH8yI8w3OOoE88vLs=;
        b=uLMq7o7zs3f6OEPobCqo/x9yTZLEMqdqBu0/2gND1KP2tTkBZGN8Sv9Rr4my0RTqgW
         35gbJOEjDGZrIwrdmcjtvIYBR9Dsa0y7Sr01CFUYgTuSW1/rC5feH+LQk3FkuHFaIfqf
         nbUY5uaKo41CQp21TiKztFKi/ep+MkDGDLIl9WNLGdIDdzWbMo4XGH3RdGD++O0lXJgF
         DboZewf2TeeLaSp8OAv05yxVQCOP+mnyZskKGuR11KyunlFWIDRVjKSGmYwMX4oyM16j
         mmyJzwkYlymvckMeciF0d5D7/CRCUw9lPMFD4IbCfpb9bR8W1Z2GfsR6H4EqmpgDOnzG
         VgbA==
X-Gm-Message-State: AOAM530zaoTX4M5CL0EMcTYeIRwnvC13DhZ0B2MeE6MnlG7CRKaqCUVc
        nrgqHLQUdNkZ/1Cr7EFXUYnELaP+dTk6srHH
X-Google-Smtp-Source: ABdhPJyF6PFG5FYaKsxm3YwPWAzH/9JZD7l2GoSx+Y0xpwtP5/mrlBqPHPUBqxfqipO1w3pqn9zcHQ==
X-Received: by 2002:a05:6808:82:: with SMTP id s2mr10309483oic.151.1624610662281;
        Fri, 25 Jun 2021 01:44:22 -0700 (PDT)
Received: from [192.168.86.162] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id k18sm697172otj.68.2021.06.25.01.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 01:44:21 -0700 (PDT)
Subject: Re: lsattr: incorrect size for ioctl result
To:     Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
Date:   Fri, 25 Jun 2021 04:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/24/21 5:07 AM, Denys Vlasenko wrote:
> On Thu, Jun 24, 2021 at 10:53 AM Rob Landley <rob@landley.net> wrote:
>>
>> On 6/23/21 6:41 AM, Denys Vlasenko wrote:
>> >   unsigned long flag = 0, version = 0;
>> >   int fd;
>> >   struct stat sb;
>> > ...
>> >   if (FLAG(v)) {
>> >     if (ioctl(fd, FS_IOC_GETVERSION, (void*)&version) < 0) goto LABEL2;
>> >     xprintf("%-10lu ", version);
>> >   }
>> >
>> > if (ext2_getflag(fd, &sb, &flag) < 0) perror_msg("reading flags '%s'", path);
>> > ...
>> >
>> > The above only works on little-endian.
>> > (The hint is in zeroing assignments at the beginning).
>> ...
>> > These ioctls return an int-sized result, not long.
>> > (Check the kernel source to verify).
>>
>> Looks to me like the kernel source is taking a long?
>>
>> include/uapi/linux/fs.h:#define FS_IOC_GETVERSION   _IOR('v', 1, long)
> 
> No. The above is a lie.

If so that's a kernel bug. That was out of current git.

>> Has since 2006: https://github.com/torvalds/linux/commit/36695673b012
>>
>> There's a FS_IOC32_GETVERSION but that's not what we're using here?
> 
> fs/ext2/ioctl.c:
> ...
>         case EXT2_IOC_GETFLAGS:
>                 flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
>                 return put_user(flags, (int __user *) arg);
> ...
>         case EXT2_IOC_GETVERSION:
>                 return put_user(inode->i_generation, (int __user *) arg);
> 
> 
> To verify, replace
> 
> - unsigned long flag = 0, version = 0;
> + unsigned long flag = -1L, version = -1L;
> 
> and see what x86-64 version of the lsattr -v shows.

Hmmm, btrfs is also using int __user *arg, xfs is using int... you're right.
That's a bug in the kernel headers.

Except int isn't right either, it's gotta be unsigned or else it's negative half
the time (which is not what lsattr -v shows). But fs/xfs/xfs_ioctl.c
fs/btrfs/ioctl.c fs/ext2/ioctl.c are all using signed "int *". Not that it
matters quite as much what they do internally, but I think the right patch is
probably:

--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -203,8 +203,8 @@ struct fsxattr {

 #define        FS_IOC_GETFLAGS                 _IOR('f', 1, long)
 #define        FS_IOC_SETFLAGS                 _IOW('f', 2, long)
-#define        FS_IOC_GETVERSION               _IOR('v', 1, long)
-#define        FS_IOC_SETVERSION               _IOW('v', 2, long)
+#define        FS_IOC_GETVERSION               _IOR('v', 1, unsigned int)
+#define        FS_IOC_SETVERSION               _IOW('v', 2, unsigned int)
 #define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
 #define FS_IOC32_GETFLAGS              _IOR('f', 1, int)
 #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)

Which raises the question "why is there an IOC32 version of this when it was
never NOT 32 bit" and "does GETFLAGS have the same problem"? (Haven't looked...)

David: opinion?

Rob
