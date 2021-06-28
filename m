Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC93B68FA
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhF1TUn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhF1TUm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 15:20:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8690EC061574
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 12:18:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q23so2406224oiw.11
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3RRHA8CycfSzY5CP+J2PbBMM2KKdmQ4+3oOwZLaARdo=;
        b=bwWj35MQvWncAlerhcGy3Bz0tf426Dehte27MYCA91S+Djy5pKabygocgFjT079p3b
         VjPdsV+BK3LnUCyXt5/wu0zj6/iboLYkW3oTLPgDyWt16lwJAmPHeVNj42xG/9/HRp/2
         1efs15jcS64jTu9dxfAUqJdavXWFOHl89/j/IYmBWEKgOd/9uVtJQPLDHqCtbA91wm0D
         PLmaIYsS9GPW7zbQmOQdJShBHyjmZjVnWzEiPItORAXzbkmsB6NwBkkK6PmBYbTaagFd
         Ios0bP2LHaJ6blsgeQ/VM9oT4jMXESKjCwkkwT7GLRihjet7aAET26HNe/juo5OWGYpN
         W0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RRHA8CycfSzY5CP+J2PbBMM2KKdmQ4+3oOwZLaARdo=;
        b=WVMrZwcBEumTCUgGChA4cqcSl32iurhbTBCKTMc0mumzYf0a1fnuVn8MKwrRxrtZZs
         dN3kdmFvF1BlZvJoL/YsTyFgkJ5kt468CWMBkfIoU5KQIalCyN66Z5r7MSsFuLJTDbpP
         okQtMN/KpPGcFb/yUa5jA5BYqSNwXqevYwdDW0PurFSfh+MyWLfOnZpywpE0B/IBK/Y+
         yFfr9hedFjnmHs6FFPuQma129XnZMy3Nz7NPrYPkYE+oabhKromHVAcJ6V8pB/lAQFjS
         wcrYy+zKdjhY+2yMDf8K4JoGMRus8wAa5Ox7dvtgImEudK18Sp2h0/dK8aVwY6x7ijzh
         f7UQ==
X-Gm-Message-State: AOAM530FbH4rVbZD2HlF9VDeF3gCfH80/tNoZK9K66IRfo/6kwU9oM/U
        KaV2BcRk1qIbFUEdGT4t9rfNnA==
X-Google-Smtp-Source: ABdhPJxA92txGwQ1EXWuDCYzD5MtW4++rES+n62emHjaimAtYLZzRAbESlOf/GXMCyjfH6PNfEK7yQ==
X-Received: by 2002:aca:ed16:: with SMTP id l22mr452344oih.17.1624907895888;
        Mon, 28 Jun 2021 12:18:15 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id z2sm1090471otm.2.2021.06.28.12.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:18:15 -0700 (PDT)
Subject: Re: lsattr: incorrect size for ioctl result
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net> <YNn5v7CTRsDo1mDO@mit.edu>
From:   Rob Landley <rob@landley.net>
Message-ID: <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net>
Date:   Mon, 28 Jun 2021 14:35:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNn5v7CTRsDo1mDO@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/28/21 11:33 AM, Theodore Ts'o wrote:
> On Fri, Jun 25, 2021 at 04:01:27AM -0500, Rob Landley wrote:
>> > No. The above is a lie.
>> 
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -203,8 +203,8 @@ struct fsxattr {
>> 
>>  #define        FS_IOC_GETFLAGS                 _IOR('f', 1, long)
>>  #define        FS_IOC_SETFLAGS                 _IOW('f', 2, long)
>> -#define        FS_IOC_GETVERSION               _IOR('v', 1, long)
>> -#define        FS_IOC_SETVERSION               _IOW('v', 2, long)
>> +#define        FS_IOC_GETVERSION               _IOR('v', 1, unsigned int)
>> +#define        FS_IOC_SETVERSION               _IOW('v', 2, unsigned int)
>>  #define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
>>  #define FS_IOC32_GETFLAGS              _IOR('f', 1, int)
>>  #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
> 
> The problem is that there are a large number of userspace programs
> which are using _IOR('v', 1, long) (the codepoint for
> FS_IOC_GETVERSION for decades), but are expecting the kernel to fill
> in an int.

Because if we don't any 64 bit version breaks on big endian. (And possibly also
if userspace didn't prezero the long.)

I agree changing the behavior of FS_IOC_* to do what the export says it does
would break binary compatibility, which is why my patch went the other way.
There's already FS_IOC32_* and I thought the suggested change would export their
ioctl numbers for both sets of names. (Does that not work?)

Maybe for compatibility/cleanup/pruning internal codepaths something like:

--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -1144,13 +1144,13 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned
int, cmd,
 #endif

        /*
-        * These access 32-bit values anyway so no further handling is
-        * necessary.
+        * These are defined "long" but access int values, so force to IOC32
         */
-       case FS_IOC32_GETFLAGS:
-       case FS_IOC32_SETFLAGS:
-               cmd = (cmd == FS_IOC32_GETFLAGS) ?
-                       FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
+       case FS_IOC_GETVERSION:
+       case FS_IOC_SETVERSION:
+       case FS_IOC_GETFLAGS:
+       case FS_IOC_SETFLAGS:
+               if (sizeof(long) == 8) cmd ^= 12 << _IOC_SIZESHIFT;
                fallthrough;
        /*
         * everything else in do_vfs_ioctl() takes either a compatible

... would mean all the filesystems only ever see IOC32 and if they want to add
64 at some point probably use a new number for it?

At the moment I'm just trying to go "can the next person not hit the same issue
I hit, which Denys presumably notified me about because HE hit it".

> We also need to be a bit careful when we make these sorts of changes
> of #defines, so we don't break kernel code like this: 

*shrug* I dunno how it should be properly fixed, just heads up that it's borked.

> long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> {
> 	/* These are just misnamed, they actually get/put from/to user an int */

Of course given that comment I guess they already knew. The comment was added 18
years ago:

https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=835a765ed1e1ef5814c9e8c6e1b64b63f8a335c9

And yet the uapi headers still don't have any comments next to the ioctl export
warning that the long is wrong:

-- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -201,15 +201,19 @@ struct fsxattr {

 #define FSLABEL_MAX 256        /* Max chars for the interface; each fs may
differ */

+/* Warning: these actually read/write an unsigned int, not long */
 #define        FS_IOC_GETFLAGS                 _IOR('f', 1, long)
 #define        FS_IOC_SETFLAGS                 _IOW('f', 2, long)
 #define        FS_IOC_GETVERSION               _IOR('v', 1, long)
 #define        FS_IOC_SETVERSION               _IOW('v', 2, long)
-#define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
+
+/* Functionally equivalent to the FS_IOC_{GET,SET}{FLAGS,VERSION} above */
 #define FS_IOC32_GETFLAGS              _IOR('f', 1, int)
 #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
 #define FS_IOC32_GETVERSION            _IOR('v', 1, int)
 #define FS_IOC32_SETVERSION            _IOW('v', 2, int)
+
+#define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
 #define FS_IOC_FSGETXATTR              _IOR('X', 31, struct fsxattr)
 #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX])

> (This is from 4.4's fs/ext2/ioct.c; the point is if we want to "fix"
> the definition of *_IOC_GETFLAGS because of a pearl clutching fit that
...
>> Which raises the question "why is there an IOC32 version of this when it was
>> never NOT 32 bit" and "does GETFLAGS have the same problem"? (Haven't looked...)
> 
> Probably because the people who added the IOC32 versions didn't
> understand this at the time?  :-)

Let me see if I understand:

1) The API the kernel exports is not what the kernel is doing.
2) Userspace can't reliably use the API the way it's currently exported.
3) Even other kernel devs "didn't understand" it.
4) Fixing it would involve scare quotes and result from a pearl clutching fit.

... no, I'm pretty sure I don't understand.

*shrug* I've cc'd Michael Kerrisk in hopes he can update the man pages. "man
ioctl_list" already documents these ioctls correctishly (modulo the
signed/unsigned part) but might benefit from some sort of "warning, do not trust
the kernel headers here, they are wrong" comment.

Rob
