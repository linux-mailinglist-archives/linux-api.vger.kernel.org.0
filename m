Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74807758374
	for <lists+linux-api@lfdr.de>; Tue, 18 Jul 2023 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGRR1S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Jul 2023 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGRR1S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Jul 2023 13:27:18 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE261711;
        Tue, 18 Jul 2023 10:27:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-576a9507a9bso103368737b3.1;
        Tue, 18 Jul 2023 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689701232; x=1692293232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EitCV8L/5kHKMNWP+m3nZoYflfzgDbS0oOR+mB4+WM=;
        b=eeim6eLftiu5wQ4cJzyD0ELWWo75kP+t8nsimfHV8739n/VlUhxNm7gUQnEUpv3ahl
         IsLaiHfNXLJJ191gbeft5qjX3y3tfkFwIfoRsBOLMPc4t5hWsqRqFXJDwWyU8Z3jpQnI
         3zWJAxK2wUPQrgQk6jWIUpdVIi26W5rL0VKfSPPsHXV9VIMmY7c1cazGDg4dF9LpZTQ4
         r43FTg1ewzmpQfPqZTw6fDgtWt80okEJcV9saY8GyXLfDwXp4yZ9lEPIJAc1n+ws/+ky
         aHQRd9EID85iOhSviooJCBNsORwAHc2p24abbDM46RC++ae9BxRv3L5tml49Dq9qtvia
         DhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689701232; x=1692293232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EitCV8L/5kHKMNWP+m3nZoYflfzgDbS0oOR+mB4+WM=;
        b=knYZXNSOXQ6NujmmmMbBbFtIBNo5Iq9f0ZLQlsGslH2vN7B3VkCGMumVlco+RVxhRz
         Y20oNzKDgGsWpam3bU7YABO/cfbkj6ytpQl3pdTwMlkBAPb4yVb7MBWyIP/2dk2jiciZ
         SKTsV4mb+lbOJwe6DQwZZuj/I/jE0ydtsH3+UvXhdWS9Se4dUlYOYt6CTNkxztBQwG/f
         DjFSC+Up8fr1JUNPkIOPvAavYyftbmhtY8JTa63oxqA1oHHPL2DdpCqTZEOQdGhifQrb
         xisWI984y5kLhPnAaUU22R4eL2UauFhGk0KdEbTI58yPCXb1zT15+eQ3bcBBFhxvtP+3
         ItxA==
X-Gm-Message-State: ABy/qLY4RcNRy43TiUuJD3AXT6HwVCQY9EG3rLblV4DgK/VEib5+UcW1
        CICQWA229W9a2kgWYmQf8vo=
X-Google-Smtp-Source: APBJJlGpb8CoGpCfXVSZR+nIvlah3LFCk7HHojmZWZsB67LiT3FfV041LGBjrK2aDj+tswkWh4n4ug==
X-Received: by 2002:a0d:cbd7:0:b0:57a:8de8:e3f8 with SMTP id n206-20020a0dcbd7000000b0057a8de8e3f8mr15118947ywd.22.1689701231774;
        Tue, 18 Jul 2023 10:27:11 -0700 (PDT)
Received: from firmament.local (c-73-106-204-164.hsd1.ga.comcast.net. [73.106.204.164])
        by smtp.gmail.com with ESMTPSA id i69-20020a819148000000b005774338d039sm566456ywg.96.2023.07.18.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:27:11 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] recv.2: Document MSG_CMSG_CLOEXEC as returned in msg_flags
Date:   Tue, 18 Jul 2023 13:26:08 -0400
Message-ID: <20230718172648.943269-1-mattlloydhouse@gmail.com>
In-Reply-To: <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
References: <20230709213358.389871-1-mattlloydhouse@gmail.com> <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org> <20230716234803.851580-1-mattlloydhouse@gmail.com> <47e21a59-f74a-4a63-0f13-237c015ae6bb@kernel.org> <20230718060121.934187-1-mattlloydhouse@gmail.com> <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Ever since commit 4a19542e5f69 ("O_CLOEXEC for SCM_RIGHTS") added the
MSG_CMSG_CLOEXEC flag to recvmsg(2), the flag has also been copied into the
returned msg->msg_flags when specified, regardless of whether any file
descriptors were actually received, or whether the protocol supports
receiving file descriptors at all. This behavior was primarily an
implementation artifact: by copying MSG_CMSG_CLOEXEC into the msg_flags,
scm_detach_fds() in net/core/scm.c (and its _compat() counterpart in
net/compat.c) could determine whether it was set without having to receive
a copy of the recvmsg(2) flags.

This mechanism was closely modeled after the internal MSG_CMSG_COMPAT flag,
which is passed by the compat versions of the send[m]msg(2) and
recv[m]msg(2) syscalls to inform various functions that user space expects
a compat layout. When the flag was first implemented by commits
3225fc8a85f4 ("[NET]: Simplify scm handling and sendmsg/recvmsg invocation,
consolidate net compat syscalls.") and 7e8d06bc1d90 ("[COMPAT]: Fix
MSG_CMSG_COMPAT flag passing, kill cmsg_compat_recvmsg_fixup.") (in
history/history.git), the behavior was very similar: recvmsg(2) would add
MSG_CMSG_COMPAT to the msg_flags, and put_cmsg() and scm_detach_fds() in
net/core/scm.c would read the flag to determine whether to delegate to
their _compat() counterparts.

However, after the initial implementation, more work was done to hide
MSG_CMSG_COMPAT from user space. First, commit 37f7f421cce1 ("[NET]: Do not
leak MSG_CMSG_COMPAT into userspace.") started scrubbing the bit from
msg_flags right before copying it back into user space. Then, since passing
the MSG_CMSG_COMPAT flag into the syscalls from non-compat code could
confuse the kernel, commits 1be374a0518a ("net: Block MSG_CMSG_COMPAT in
send(m)msg and recv(m)msg") and a7526eb5d06b ("net: Unbreak
compat_sys_{send,recv}msg") made them return -EINVAL if user space
attempted to pass the flag. But to reduce breakage, commit d720d8cec563
("net: compat: Ignore MSG_CMSG_COMPAT in compat_sys_{send, recv}msg")
rolled that back somewhat, making MSG_CMSG_COMPAT an error for the
non-compat syscalls and a no-op for the compat syscalls, which is the
current status quo.

Even though MSG_CMSG_CLOEXEC was implemented after the kernel started
scrubbing MSG_CMSG_COMPAT from the returned msg_flags, the newer flag never
received the same treatment. At this point, this behavior has effectively
become part of the user-space API, to the extent that io_uring has been
careful in commit 9bb66906f23e ("io_uring: support multishot in recvmsg")
to replicate the behavior in its multishot IORING_OP_RECVMSG operation.

Therefore, document this behavior to avoid confusion when user space sees
MSG_CMSG_CLOEXEC returned in msg->msg_flags.

Cc: linux-api@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Matthew House <mattlloydhouse@gmail.com>
---
Alright, I've summarized the history in the commit message, and I've added
the CCs you requested.

Also, for future reference, Drepper gave a reply to the last email, which
did not make it onto the list:

On Tue, Jul 18, 2023 at 9:24 AM Ulrich Drepper <drepper@redhat.com> wrote:
> On Tue, Jul 18, 2023 at 2:10=E2=80=AFPM Alejandro Colomar <alx@kernel.org=
> wrote:
>
> > > As for the original
> > > purpose of the behavior, it's not really clear, and it may well have =
been
> > > an implementation artifact that got enshrined in the user space ABI.
> > (Even
> > > io_uring is careful to replicate this behavior!)
> >
> > This is what worries me.  I've CCd a bunch of people to see if they can
> > bring some light.
> >
>
> It definitely was an artifact of the implementation.  I haven't tested
> getting the close-on-exec flag information for all interfaces.  The
> assumption was that the information about the close-on-exec flag is
> received with the universal fcntl() call.

Thank you,
Matthew House

 man2/recv.2 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/man2/recv.2 b/man2/recv.2
index 660c103fb..1cd9f3e1b 100644
--- a/man2/recv.2
+++ b/man2/recv.2
@@ -412,6 +412,15 @@ is returned to indicate that expedited or out-of-band =
data was received.
 .B MSG_ERRQUEUE
 indicates that no data was received but an extended error from the socket
 error queue.
+.TP
+.BR MSG_CMSG_CLOEXEC " (since Linux 2.6.23)"
+.\" commit 4a19542e5f694cd408a32c3d9dc593ba9366e2d7
+indicates that
+.B MSG_CMSG_CLOEXEC
+was specified in the
+.I flags
+argument of
+.BR recvmsg ().
 .SH RETURN VALUE
 These calls return the number of bytes received, or \-1
 if an error occurred.
--=20
2.41.0

