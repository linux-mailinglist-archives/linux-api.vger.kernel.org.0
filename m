Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563FC37AE5
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfFFRVc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 13:21:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44465 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfFFRVc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Jun 2019 13:21:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so1374310ljc.11
        for <linux-api@vger.kernel.org>; Thu, 06 Jun 2019 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=GXSY8IkFrWa7J8B6PJEPqJ0gkrWF9aF2wuVJ0wQ40ziAUSXofomBUgMg2tSIClx+89
         +trdK2/MhDj4EjpP2yv3Xn8pX3rA48qk6bQhrjbIVV9fY3W5uHsxoW6S3hiV1u6bue1h
         +WQ8hOkagCs/4IfWuZtcPZAZi6BK/PN2CpG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=d7FQKr9YSRzSpMZtrBOGyfX0aFnhNhxQ8Gvz2S/ofeEa7Aw3sIHTStgxa8Ym+lyWAF
         c1S3PioRjR1uRyhHa76G47Jt6PhVh+bG1phXiHh6Lz7CwF6VOsc/skFIGAhVuaEiC5Vo
         6T4Ag+wOYe00twvLEW3FXezmuzDA0/oJ6mtbMuvw4VhTvcncoaTVNKZdz5tpYUyKj5Bv
         w4GL+ImaVIKxoniyQMQllZ/yCAx1gHPXCsv0YHqG1/xJ/YAquTZLu8h+W5RkprGVFR6p
         V2nSILKP9p0Ho7UOjfrj5yRIT0IEG12T6rtdNNfweAt44GtkOf6+/w508zTiT3cwNAok
         Bhqw==
X-Gm-Message-State: APjAAAWRlqs4N9oZ+go8w9fUq6T4BfDN5fArjM+N8Ghb7kaF7SqTJJWA
        FvQJVzg5I/A5mTwuudhBdQMIRFZMQWs=
X-Google-Smtp-Source: APXvYqx75CCwYwY4CdSWntJ+KgFYaifU+2TdPV3DEu+f05EKSqCT5HMCnTqg1pXvW0PfJzjjNeCO5A==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr7711867ljj.1.1559841689521;
        Thu, 06 Jun 2019 10:21:29 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d23sm456952ljj.38.2019.06.06.10.21.28
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id i21so2812033ljj.3
        for <linux-api@vger.kernel.org>; Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr26100221ljj.147.1559841687851;
 Thu, 06 Jun 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190606155205.2872-1-ebiggers@kernel.org>
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jun 2019 10:21:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] fs-verity: read-only file-based authenticity protection
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This is a redesigned version of the fs-verity patchset, implementing
> Ted's suggestion to build the Merkle tree in the kernel
> (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> This greatly simplifies the UAPI, since the verity metadata no longer
> needs to be transferred to the kernel.

Interfaces look sane to me. My only real concern is whether it would
make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
could be done incrementally, since the way it is done now it looks
like any random user could create a big file and then do the
FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
operation.

Yes, I see the

+               if (fatal_signal_pending(current))
+                       return -EINTR;
+               cond_resched();

in there, so it's not like it's some entirely unkillable thing, and
maybe we don't care as a result. But maybe the ioctl interface could
be fundamentally restartable?

If that was already considered and people just went "too complex", never mind.

               Linus
