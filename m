Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74321B9599
	for <lists+linux-api@lfdr.de>; Fri, 20 Sep 2019 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393651AbfITQZI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Sep 2019 12:25:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39583 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393409AbfITQZI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Sep 2019 12:25:08 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so17507336ioc.6
        for <linux-api@vger.kernel.org>; Fri, 20 Sep 2019 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mdvYxDHDS8hqK4Ot9ARyH0M5hxcRfC/pXtaEBErAd8Q=;
        b=dFMPSpTQUpDPcVQWAqEZI/cbI+4Z0LB4fZE7fL3JiXgGmvfgvgqrv1s8ZWrMOdvDvc
         YDddmJi8POfbG+klNJzG4TfQAbRHXTJUWzuSqyPbE3uuGFvnXX7xTW4qj6O2f5cmCQvz
         B3shagy3lkokbk0bG+3kjDFEMC+I5pxed1t0U+i847eE2fepTDSfJx26d9Lr7kgc232q
         u6ZGobYG1E+RQyg3obngkIhvbZwE4JdszSBC1/zb3WXXuJAmBcUsF9j3zqS4jkhhFCyb
         +CoZsVO55/O/LrNnvGnBy8PXhU59T0spyAu3ZbAJudB/b5J+f5x0e7UoW/vTJl3R9H5t
         4mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mdvYxDHDS8hqK4Ot9ARyH0M5hxcRfC/pXtaEBErAd8Q=;
        b=la/HaFttet+JQeA0aalrSy1By1FqWISFAb6CZLsqk7Hl9zpQl+N6NlksZhu3E27A9H
         xyV+6RQ56iggyzl9ggZddc4ujG+dYBfUwhR8mZ2fuWe0/MOWz8MKfLc18s6hQTWzCQom
         5GbJHrfd7fOHcfnHKc6ChmA5liVKkGGxI8XqYmQUQIyJqcf5S27/VeveNr+yrmeGMzPY
         dwvrvTW3pkHjWqAq/A551Csx6+gFV+H6fdZ7iACPOMGSB3DOKpshRtvs63km1OSTyz4M
         vzXviqnRqBJh8nC8MFYdjiiEXD9kn1ADdg5XL3DmLWxK5KpfJGlpQgoxIMqwPQVJxWvB
         IOAg==
X-Gm-Message-State: APjAAAXPv3pPGPbRQri6UhHm+3yV7BZOUcbPa7A+zHQ8bQi4S5l9kZvQ
        JNHSB0PrwW60kY+XLROOf0NOiQ==
X-Google-Smtp-Source: APXvYqxeolQgNgsjFuOEJ/gxDgrgRtD++wvNZnY8Znc9LZZnmG8V6YaMbF0xzS/qUvoW8STGJ7ldbg==
X-Received: by 2002:a5d:9619:: with SMTP id w25mr1431266iol.158.1568996707089;
        Fri, 20 Sep 2019 09:25:07 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n17sm2288749ioj.73.2019.09.20.09.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:25:05 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
To:     Jann Horn <jannh@google.com>, Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf85b314-2cf7-4fcb-c116-21a271ab50fc@kernel.dk>
Date:   Fri, 20 Sep 2019 10:25:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/19/19 9:44 AM, Jann Horn wrote:
> On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
>> Btrfs can transparently compress data written by the user. However, we'd
>> like to add an interface to write pre-compressed data directly to the
>> filesystem. This adds support for so-called "encoded writes" via
>> pwritev2().
>>
>> A new RWF_ENCODED flags indicates that a write is "encoded". If this
>> flag is set, iov[0].iov_base points to a struct encoded_iov which
>> contains metadata about the write: namely, the compression algorithm and
>> the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
>> must be set to sizeof(struct encoded_iov), which can be used to extend
>> the interface in the future. The remaining iovecs contain the encoded
>> extent.
>>
>> A similar interface for reading encoded data can be added to preadv2()
>> in the future.
>>
>> Filesystems must indicate that they support encoded writes by setting
>> FMODE_ENCODED_IO in ->file_open().
> [...]
>> +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
>> +                        struct iov_iter *from)
>> +{
>> +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
>> +               return -EINVAL;
>> +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
>> +               return -EFAULT;
>> +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
>> +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
>> +               iocb->ki_flags &= ~IOCB_ENCODED;
>> +               return 0;
>> +       }
>> +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
>> +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
>> +               return -EINVAL;
>> +       if (!capable(CAP_SYS_ADMIN))
>> +               return -EPERM;
> 
> How does this capable() check interact with io_uring? Without having
> looked at this in detail, I suspect that when an encoded write is
> requested through io_uring, the capable() check might be executed on
> something like a workqueue worker thread, which is probably running
> with a full capability set.

If we can hit -EAGAIN before doing the import in io_uring, then yes,
this will probably bypass the check as it'll only happen from the
worker.

-- 
Jens Axboe

