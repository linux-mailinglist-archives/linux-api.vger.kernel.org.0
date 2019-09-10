Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB469AF007
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436958AbfIJQ5H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 12:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436957AbfIJQ5G (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Sep 2019 12:57:06 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C062D2089F
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568134626;
        bh=UMv65zBvlpgle8E7mO8AeZIREr1Yo4NYVJ1nbN8qSVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e1hX7isN+rAXTlm06BSmdEGyCvO3oQbCh6L/9Olfhzt4Y+y59rIpiBCm8PJpxCChO
         FCRcJF/2xU+q8Phok/2XXMX76E8p/JMAZlEGTHgtnqAVI+aswneboowGT8wmpPbbnn
         iARZ/NI6MaxQrc1CMVLcrjgzH43Kye41dyNNNz6I=
Received: by mail-wr1-f54.google.com with SMTP id y19so21424131wrd.3
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 09:57:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWx/A6Pi23Dozsfd8pF8uid/Eso25JqU9eg4mOm5jpiqmE/ZFjz
        H7xdp0rY4gsBuuCgIaXO4rCdN37KkDmth/wY3vuLCA==
X-Google-Smtp-Source: APXvYqzfNckRdcOeF31SlRnVdskoQYKf5gkvVGtyy8lb/m05shVLaJXCnbiercrrU11/uQLbaerxQn/FCbkMHMmLr+k=
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr19271602wrm.221.1568134624270;
 Tue, 10 Sep 2019 09:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190905005313.126823-1-dancol@google.com>
In-Reply-To: <20190905005313.126823-1-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Sep 2019 09:56:53 -0700
X-Gmail-Original-Message-ID: <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
Message-ID: <CALCETrU2Wycgdfo8vLZQUnx1J9ro=6ddSkP37BhsfBkKL1mbMA@mail.gmail.com>
Subject: Re: [RFC] Add critical process prctl
To:     Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 4, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
>
> A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
> meaning that if the task ever exits, the kernel panics. This facility
> is intended for use by low-level core system processes that cannot
> gracefully restart without a reboot. This prctl allows these processes
> to ensure that the system restarts when they die regardless of whether
> the rest of userspace is operational.

The kind of panic produced by init crashing is awful -- logs don't get
written, etc.  I'm wondering if you would be better off with a new
watchdog-like device that, when closed, kills the system in a
configurable way (e.g. after a certain amount of time, while still
logging something and having a decent chance of getting the logs
written out.)  This could plausibly even be an extension to the
existing /dev/watchdog API.

--Andy
