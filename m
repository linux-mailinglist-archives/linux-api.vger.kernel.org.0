Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B06D10FF
	for <lists+linux-api@lfdr.de>; Thu, 30 Mar 2023 23:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC3VqX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Mar 2023 17:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3VqW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Mar 2023 17:46:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370CD530;
        Thu, 30 Mar 2023 14:46:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m2so20488853wrh.6;
        Thu, 30 Mar 2023 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680212779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1Jk475IjMY0JL30bXA6f3iBvRwQ5t0sLRQAyTvVik8=;
        b=BmQLZwf6IbC1biHjC82BGqLpvFBu6wO4D1/4gwwS3PqfG8DJGtLQTB82jCAD5LpZun
         8qRcUl2b4EvCll8Bbnnz6YPC+jLdeyfDGMY0rIdYI/nMptecjZ4aBMEc/kMaYFvSBS5Y
         f/qHgSRW0Ent6n32UKctzOKK91yNJv7xmPnxgxLv1qRTrCnKM1EhEo+6V1LRpfCJxoYz
         g4fghyd3qN3Ium5tq3iYGnqeyEsjvg6RWipQu+TxqYGQtLllGmH38S3pfduuTnX/VK2z
         WYhlv5IeWE3Xzags7Xqr4vrpUvuknPYXP5TsTaC/YQana2op6ECXkI+pUBRBdCxszTkV
         mEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680212779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Jk475IjMY0JL30bXA6f3iBvRwQ5t0sLRQAyTvVik8=;
        b=tSQ4gc+rJxHt1uSUii4YinHnGGnvpASZiUF/5ZvILBrXvvEH17fe8CFzwtvdNbI/pV
         x7rO6eKvkMGHvQH1xUuTLEUgb3xuV2RT+X7w7niJOBL5ayKHxrh0QJeg6+Qp4e0N/I58
         9Fu0IB4XQrZ6nctw2vTdqxDRMgp6i+ZmOF9l0My/X9vOXNKqn5D1ghRVmhK46ohykAVx
         Sgl47Yc5PVL9Xni7lLoQFeIc99FEC7dAsRlL6tJGGejQMkHQWmq0qCgbZjFZ4IJ1KAOR
         Xu6JvsyLHXcD0GnYpqfnzTXNRG9sIPgghXEu5U2lfMB+CcAvIwn8gaE/qSl1kn5KrggI
         K6cA==
X-Gm-Message-State: AAQBX9eK9vZHNU48ZvaYD2yw+pyjQYY30v7slqQWO0IRUkkKE1TEY8E0
        KftAm6kNd/+4OOAI4xupjMfJ0PZ2yBw=
X-Google-Smtp-Source: AKy350YaRFFB3xxobFlglKBbgiRZZuknlk/LsyEySw9oyQtlo2TmQXta8yEb+TxeI9sURd5551b/kw==
X-Received: by 2002:a5d:4406:0:b0:2e5:26eb:bd1b with SMTP id z6-20020a5d4406000000b002e526ebbd1bmr1849193wrq.58.1680212778974;
        Thu, 30 Mar 2023 14:46:18 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:fdcf:52c5:7af:c812])
        by smtp.gmail.com with ESMTPSA id y13-20020adff14d000000b002c55306f6edsm414676wro.54.2023.03.30.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:46:17 -0700 (PDT)
Date:   Thu, 30 Mar 2023 22:46:17 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Herrmann <dh.herrmann@gmail.com>, yshuiv7@gmail.com,
        bugzilla-daemon@kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [Bug 217238] New: Creating shared read-only map is denied after
 add write seal to a memfd
Message-ID: <ZCYDKeuAttQJHm8S@murray>
References: <a586f817-dbe4-4a44-b516-6086d9a89962@lucifer.local>
 <6793EAB9-CF91-425A-B278-8A5D4415AD72@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6793EAB9-CF91-425A-B278-8A5D4415AD72@amacapital.net>
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 30, 2023 at 01:47:48PM -0700, Andy Lutomirski wrote:
>
>
> > On Mar 30, 2023, at 12:25 PM, Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> >
> > ﻿On Sat, Mar 25, 2023 at 02:51:05PM +0000, Lorenzo Stoakes wrote:
> >>> On Fri, Mar 24, 2023 at 01:36:46PM -0700, Andrew Morton wrote:
> >>> (switched to email.  Please respond via emailed reply-to-all, not via the
> >>> bugzilla web interface).
> >>>
> >>>> On Fri, 24 Mar 2023 03:34:23 +0000 bugzilla-daemon@kernel.org wrote:
> >>>
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=217238
> >>>>
> >>>>            Bug ID: 217238
> >>>>           Summary: Creating shared read-only map is denied after add
> >>>>                    write seal to a memfd
> >>>>           Product: Memory Management
> >>>>           Version: 2.5
> >>>>    Kernel Version: 6.2.8
> >>>>          Hardware: All
> >>>>                OS: Linux
> >>>>              Tree: Mainline
> >>>>            Status: NEW
> >>>>          Severity: normal
> >>>>          Priority: P1
> >>>>         Component: Other
> >>>>          Assignee: akpm@linux-foundation.org
> >>>>          Reporter: yshuiv7@gmail.com
> >>>>        Regression: No
> >>>>
> >>>> Test case:
> >>>>
> >>>>    int main() {
> >>>>      int fd = memfd_create("test", MFD_ALLOW_SEALING);
> >>>>      write(fd, "test", 4);
> >>>>      fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE);
> >>>>
> >>>>      void *ret = mmap(NULL, 4, PROT_READ, MAP_SHARED, fd, 0);
> >>>>    }
> >>>>
> >>>> This fails with EPERM. This is in contradiction with what's described in the
> >>>> documentation of F_SEAL_WRITE.
> >>>>
> >>>> --
> >>>> You may reply to this email to add a comment.
> >>>>
> >>>> You are receiving this mail because:
> >>>> You are the assignee for the bug.
> >>>
> >>
> >> This issue seems to be the result of the use of the memfd's shmem region's
> >> page cache object (struct address_space)'s i_mmap_writable field to denote
> >> whether it is write-sealed.
> >>
> >> The kernel assumes that a VM_SHARED mapping might become writable at any
> >> time via mprotect(), therefore treats VM_SHARED mappings as if they were
> >> writable as far as i_mmap_writable is concerned (this field's primary use
> >> is to determine whether, for architectures that require it, flushing must
> >> occur if this is set to avoid aliasing, see filemap_read() for example).
> >>
> >> In theory we could convert all such checks to VM_SHARED | VM_WRITE
> >> (importantly including on fork) and then update mprotect() to check
> >> mapping_map_writable() if a user tries to make unwritable memory
> >> writable.
> >>
>
> Unless I’m missing something, we have VM_MAYWRITE for almost exactly this purpose.  Can’t we just make a shared mapping with both of these bits clear?
>

That's a good point, and there's definitely quite a few places where
VM_SHARED is simply taken to imply writable which is a little irksome,
however sprinkling some VM_MAYWRITE checks in these places would resolve
that.

Let me take a look into this and perhaps spin up a RFC to iron out the
 details if this is indeed viable.

> >> I suspect however there are reasons relating to locking that make it
> >> unreasonable to try to do this, but I may be mistaken (others might have
> >> some insight on this). I also see some complexity around this in the
> >> security checks on marking shared writable mappings executable (e.g. in
> >> mmap_violation_check()).
> >>
> >> In any case, it doesn't really make much sense to have a write-sealed
> >> shared mapping, since you're essentially saying 'nothing _at all_ can write
> >> to this' so it may as well be private. The semantics are unfortunate here,
> >> the memory will still be shared read-only by MAP_PRIVATE mappings.
> >>
> >> A better choice here might be F_SEAL_FUTURE_WRITE (available from kernel
> >>> =5.1) which does permit shared read-only mappings as this is explicitly
> >> checked for in seal_check_future_write() invoked from shmem_mmap().
> >>
> >> Regardless, I think the conclusion is that this is not a bug, but rather
> >> that the documentation needs to be updated.
> >>
> >
> > Adding docs people to cc list (sorry didn't think to do this in first
> > reply).
