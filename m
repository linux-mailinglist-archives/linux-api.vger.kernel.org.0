Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03592C7778
	for <lists+linux-api@lfdr.de>; Sun, 29 Nov 2020 05:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgK2EDc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Nov 2020 23:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgK2EDc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 28 Nov 2020 23:03:32 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C778E2080C
        for <linux-api@vger.kernel.org>; Sun, 29 Nov 2020 04:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606622572;
        bh=fpFkVbYv/EnCNsW2ueDD/AGTwJaapL1qa4U4E15PkAQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u3pgUX9XHbkTi00cZzpD6LdMEYkEpRLtm8bDw1a708Q06OJ/RNYm/E7whgWh2SpvH
         RqDWihea8B+XV5mLK4MK9rxjtyEXr/Y182FpN1JC5AE3vgAzu3gDz5C8T97Zv6fUG6
         ZJkZ4s+e1GJXpp3DhBFcIgxRuLCoz3JIIYtIns5Q=
Received: by mail-wr1-f53.google.com with SMTP id k14so10394905wrn.1
        for <linux-api@vger.kernel.org>; Sat, 28 Nov 2020 20:02:51 -0800 (PST)
X-Gm-Message-State: AOAM530OQ6p08Sv7k0+yMW9h5lluOwMcjt95frnhqoN9/00QIOPmbVA4
        spfrdyV/ejZi8q9X9UNy4vqBmjKJCP8xEtA/k8ZLuA==
X-Google-Smtp-Source: ABdhPJxNy9eTUpxV3m/NNL2Ntz4eYZ1oMzR+1glTtZBYeawNGeRx1kWDAvX/BxwiuW55WQ25usNdny0jjkBZ24hdG3o=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr20029975wro.184.1606622570428;
 Sat, 28 Nov 2020 20:02:50 -0800 (PST)
MIME-Version: 1.0
References: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Nov 2020 20:02:37 -0800
X-Gmail-Original-Message-ID: <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
Message-ID: <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
Subject: Re: [RFC net-next af_unix v1 0/1] Allow delivery of SIGURG on AF_UNIX
 streams socket
To:     rao.shoaib@oracle.com
Cc:     Christoph Hellwig <hch@lst.de>, Paolo Abeni <pabeni@redhat.com>,
        jbi.octave@gmail.com, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 28, 2020 at 7:07 PM <rao.shoaib@oracle.com> wrote:
>
> From: Rao Shoaib <rao.shoaib@oracle.com>
>
> We have a use case where thousands of processes connect locally to a
> database and issue queries that are serviced by a pool of threads.
> Communication is done over AF_UNIX sockets. Currently, there is no way
> for the submitter to signal the servicing thread about an urgent
> condition such as abandoning the query.

Sure there is.  You could close() the socket.  You could send() a
message saying that your query wants to be canceled.  You could use a
second socket for this if it's somehow inconvenient to do it with a
single socket.

> This patch addresses that
> requirement by adding support for MSG_OOB flag for AF_UNIX sockets.
> On receipt of such a flag, the kernel sends a SIGURG to the peer.

SIGURG is a horrible interface.  It doesn't scale -- signals are slow,
and they give no indication of *which* socket has urgent data.  Aside
from this, the "urgent" interface itself is nuts -- even the TCP RFCs
and implementations seem unable to agree on exactly how to tell
*which* data is urgent.  At least epoll might be a scalable way to
tell which socket has urgent data, but that's not what your patch
description seems to be talking about.

Oh yeah, SIGURG simply doesn't work across privilege boundaries.

I'm also a bit nervous that there might be some program out there that
expects SIGIO but not SIGURG on unix sockets, and you're breaking
them.

--Andy
