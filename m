Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86F8220B8B
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgGOLMY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOLMW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 07:12:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505EDC061755
        for <linux-api@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o18so1737419eje.7
        for <linux-api@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=JZLRSBhWm0oHxV3fok6cxthIXvhjAenz53D8fezRJjLbsEGzev4V175VrT5tTOPQ0L
         XAnaq/Ov0CMEsnpV/F+V8rK7u1bIHghoUkChEQwbMY9tpBz4kn9ZGAYdf+rjrsnXqUDy
         +MzGC5vqoZD/qK6UbJ4A75mLpvNLy6Zar3ArQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=FDc6WSvt/qRmiABeJ4B4ZzmhwpU4vv94VAg5FOKnzAc24PyY5B7M17e25D8xh3287x
         dITwoCwUmc2EI2uw2CUoiUg2GxQkcDNSUAUjqndPF8ZoGJoYEeNV64MZ9j86ZS5YGWCG
         UTJVpqzP/rpvJYpKyJRdzgehrGF561NzGJVBiPVu6rtI4nE+Z9us9ar2V6AFNSt7FQxv
         VOlle9+cU6e9X0iTCO50ZuMGNADeDAr6OeJaHiUfKc21z4c57vUa1y8G8+N3de/208lu
         swn43sLUZbNroNotGlCz/9oq7TvBTELcjbLpFlcnJOqLHnErsDunekK23adx9/p+OrFd
         DdCw==
X-Gm-Message-State: AOAM5338HPW4Lhgf3m9/svj1geuJZCMTbmnZezeZeZKrVmj/FwbHKrxB
        /+iRSBv3PCpioOwCYFVxV6GghI1U1nFn+qkzb7y2ug==
X-Google-Smtp-Source: ABdhPJw0oIZdNNSQSx2dAWVRtVjY5tScV5cqBbhIhCHnr1dD6YokQZCqwZVPmd0NLTWPqfK15c8L+dhgVb8e5/u5u6o=
X-Received: by 2002:a17:906:b74e:: with SMTP id fx14mr8403146ejb.202.1594811541019;
 Wed, 15 Jul 2020 04:12:21 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 13:12:09 +0200
Message-ID: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
Subject: strace of io_uring events?
To:     strace-devel@lists.strace.io, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

This thread is to discuss the possibility of stracing requests
submitted through io_uring.   I'm not directly involved in io_uring
development, so I'm posting this out of  interest in using strace on
processes utilizing io_uring.

io_uring gives the developer a way to bypass the syscall interface,
which results in loss of information when tracing.  This is a strace
fragment on  "io_uring-cp" from liburing:

io_uring_enter(5, 40, 0, 0, NULL, 8)    = 40
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
...

What really happens are read + write requests.  Without that
information the strace output is mostly useless.

This loss of information is not new, e.g. calls through the vdso or
futext fast paths are also invisible to strace.  But losing filesystem
I/O calls are a major blow, imo.

What do people think?

From what I can tell, listing the submitted requests on
io_uring_enter() would not be hard.  Request completion is
asynchronous, however, and may not require  io_uring_enter() syscall.
Am I correct?

Is there some existing tracing infrastructure that strace could use to
get async completion events?  Should we be introducing one?

Thanks,
Miklos
