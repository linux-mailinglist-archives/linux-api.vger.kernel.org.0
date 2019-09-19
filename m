Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC23DB7E71
	for <lists+linux-api@lfdr.de>; Thu, 19 Sep 2019 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfISPoj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Sep 2019 11:44:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43207 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbfISPoj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Sep 2019 11:44:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so3085092oih.10
        for <linux-api@vger.kernel.org>; Thu, 19 Sep 2019 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kvUqBQcNxOCOxtVti+j2jNfpMFcmJ7YDRZiAB8fMVI=;
        b=JSdHATBDkNlBCb3LfzQMqdXakwlYFtjrEhvg2kKmGXw6Gi0+1srQ/hFoLVw0d/mlM3
         Srx5r89gSVRcr8Z9Tqrt47fQs+rJwHij6Wa71toTKoYRDOJDcoMEQYKOaOp2RuulvACb
         +hJuWp4xgKtUl4OEx2HsOKDbDu03fFQKrfCtzjwKv7lqO67RG5ryfCkKpb6d39C6vdrl
         CeGfuiEtTf/WimxAa6RtxOSCsRA6rJdIOWsl2qCfuQKCg9L0klMMSZ5y96ty+QK5isk2
         MV1QugKveHnGabKKa0FUl2HCXCk+faxEpcWUpIxx/l2Ri8OWCBsBfISiTDaFEkg+Xtl7
         8rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kvUqBQcNxOCOxtVti+j2jNfpMFcmJ7YDRZiAB8fMVI=;
        b=X5HSu8xGDvtVAFh+lHl26aq+C1fG7PVoWDdc8G78yX2gctRvXSSxIZNhp9QzcB8tx3
         tIsUIKIbyAy5RLnMm3nNdtArRiCGq0IrcdRURofyBsffT/GraS+MjkPXpJaELOijUfbm
         fKccjtf0mNeLTsSU7QnZZ4kwMb1AB63uCNhs6DLX6/WThRMMH0dBocxwsAhf2O3rbAaE
         ySVHLmqaaZe7Dj01w6WHuPJdnrwdfwEPTDiqsAheIWXDezGQ9ggZUfczM+Ea+Sws+fQ8
         dzyzldrkyT5nZOh90rQMLwhCcjtv4P/PWnbxbifAOSnbxhp0Hvd9ve3t9ryMadpBZHsQ
         SIpg==
X-Gm-Message-State: APjAAAUe1eqVxGrSr529TBtasZM4TBZk7AgZ6gPWPCNBXILlnPiX4Ffj
        HL6Z+W5Se0gZeocnA2xHaZ1vdln0Ch1SH96x6B27vQ==
X-Google-Smtp-Source: APXvYqwv7Y0THRPcopDsfzOxxFMqSN/REmKRj1pP4r6UrP+tTi/DK5t8aZIsyIOfIes38bfT67t9gmY/s7r1oFMhkdg=
X-Received: by 2002:aca:4406:: with SMTP id r6mr2849941oia.175.1568907878436;
 Thu, 19 Sep 2019 08:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568875700.git.osandov@fb.com> <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
In-Reply-To: <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 19 Sep 2019 17:44:12 +0200
Message-ID: <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
To:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> Btrfs can transparently compress data written by the user. However, we'd
> like to add an interface to write pre-compressed data directly to the
> filesystem. This adds support for so-called "encoded writes" via
> pwritev2().
>
> A new RWF_ENCODED flags indicates that a write is "encoded". If this
> flag is set, iov[0].iov_base points to a struct encoded_iov which
> contains metadata about the write: namely, the compression algorithm and
> the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> must be set to sizeof(struct encoded_iov), which can be used to extend
> the interface in the future. The remaining iovecs contain the encoded
> extent.
>
> A similar interface for reading encoded data can be added to preadv2()
> in the future.
>
> Filesystems must indicate that they support encoded writes by setting
> FMODE_ENCODED_IO in ->file_open().
[...]
> +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> +                        struct iov_iter *from)
> +{
> +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> +               return -EINVAL;
> +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> +               return -EFAULT;
> +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> +               iocb->ki_flags &= ~IOCB_ENCODED;
> +               return 0;
> +       }
> +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> +               return -EINVAL;
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;

How does this capable() check interact with io_uring? Without having
looked at this in detail, I suspect that when an encoded write is
requested through io_uring, the capable() check might be executed on
something like a workqueue worker thread, which is probably running
with a full capability set.
