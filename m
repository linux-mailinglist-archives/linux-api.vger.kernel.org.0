Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4ABD2BB
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfIXTfQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:35:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39940 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfIXTfP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:35:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so1944275pfb.7
        for <linux-api@vger.kernel.org>; Tue, 24 Sep 2019 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3f66Rj6t9yfmXpUykMropMdqjP5kdr+L5bVpyG392ls=;
        b=MQ055M4OlnDEj799heTXTwZC1I2f0SHMqCrNU5V0DSu7gpbnMHxOXv1wwE4sSSXwaN
         tGkc2Swd7BHhjID9Cka6h7rnj4GDQNzYJ7WS4oSFNNBihZRnCsUiZPhD9PzoKyH56MhA
         T8a2oPqRmA2wDe98R6sg4c4PAAGaPSo4q478QqZK7GLAbps8l1b9J4ji0J7MOKXfQaRD
         qQb0VC1pzjCfGvOkx+VlixaJjgA7PAG/09tkB6zIgAqKjHO18TuVFrYHWk3zgXW3P6Sd
         6yD+JyzZ0po+ePjPH8odkzH9bbvsKDL6hymdVsHe4Vsu/0FAJN/Ko+GG2HNfeVwqizT+
         +leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3f66Rj6t9yfmXpUykMropMdqjP5kdr+L5bVpyG392ls=;
        b=ZDKtFvyKXZ4FDFtLtW655RvHnT2eEQUnwU8HW1BAZSrdDLp0X7Irgpghf/a+3KdtaX
         gHhSjRW115jBDhEcDJTLhPSTzouxvJtw7YdkBT3KT/jfEhz18x06IrXiiflF0YOPV+wp
         KxkU0wEwC4YXtMlhroHZ4ZY4LrsI2PsZDDq7AiHzxmC6nkRQU0rQzH5VF31EVVTm+j0S
         bEQP55UGJKTrmE6ZApHKgQw4MTDi92otTWVog8LjY+y8fI9cuRQJM2bEH9T6IQB5u9+F
         ywymuPUJiE2XYkMtN1eBKulAqymx3PJs+3f/L75TcIiJDVFcXbvuSPk0csy2LBNCz7Pw
         992w==
X-Gm-Message-State: APjAAAWHjSa5u5mDP7XwHdU6Z7XgMYTvOBDtDeVv55Gz5HcVlSHoumgO
        xS9XcesxRJt3LL0DllCpKiEOsw==
X-Google-Smtp-Source: APXvYqxIwMr4QmyPQYW76tCt8RGLj4PVLGtrh11MlsIv0OIUIKz+wghKlzvnoSEpvnnnvaVK3PHx+g==
X-Received: by 2002:a63:1749:: with SMTP id 9mr4498860pgx.387.1569353714555;
        Tue, 24 Sep 2019 12:35:14 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:f972])
        by smtp.gmail.com with ESMTPSA id fa24sm735498pjb.13.2019.09.24.12.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:35:13 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:35:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190924193513.GA45540@vader>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924171513.GA39872@vader>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 24, 2019 at 10:15:13AM -0700, Omar Sandoval wrote:
> On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> > On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > Btrfs can transparently compress data written by the user. However, we'd
> > > like to add an interface to write pre-compressed data directly to the
> > > filesystem. This adds support for so-called "encoded writes" via
> > > pwritev2().
> > >
> > > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > contains metadata about the write: namely, the compression algorithm and
> > > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > > must be set to sizeof(struct encoded_iov), which can be used to extend
> > > the interface in the future. The remaining iovecs contain the encoded
> > > extent.
> > >
> > > A similar interface for reading encoded data can be added to preadv2()
> > > in the future.
> > >
> > > Filesystems must indicate that they support encoded writes by setting
> > > FMODE_ENCODED_IO in ->file_open().
> > [...]
> > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > +                        struct iov_iter *from)
> > > +{
> > > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > +               return -EINVAL;
> > > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > +               return -EFAULT;
> > > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > > +               return 0;
> > > +       }
> > > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > +               return -EINVAL;
> > > +       if (!capable(CAP_SYS_ADMIN))
> > > +               return -EPERM;
> > 
> > How does this capable() check interact with io_uring? Without having
> > looked at this in detail, I suspect that when an encoded write is
> > requested through io_uring, the capable() check might be executed on
> > something like a workqueue worker thread, which is probably running
> > with a full capability set.
> 
> I discussed this more with Jens. You're right, per-IO permission checks
> aren't going to work. In fully-polled mode, we never get an opportunity
> to check capabilities in right context. So, this will probably require a
> new open flag.

Actually, file_ns_capable() accomplishes the same thing without a new
open flag. Changing the capable() check to file_ns_capable() in
init_user_ns should be enough.
