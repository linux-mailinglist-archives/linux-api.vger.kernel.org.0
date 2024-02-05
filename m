Return-Path: <linux-api+bounces-848-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8284AA3A
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FF51C2863A
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 23:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217C1AB7E6;
	Mon,  5 Feb 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="YpbA2d6c"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7E4F5EA
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174199; cv=none; b=rpOpvaLxIHtBDSr9Kb87euGX1kiVbh8u42NLFLWwQpPBlo6eo2HSMwlvAxk6ZudkPUNBH4YSYfho3YX7yHYeXMreIoqBsBiAqHc0OyU+PZ2RUfz4eR6beORLTRQceYlrQKhty8oHsqK6MqAeHW+/17OYA0Ft1K5QY+Xd9bqMG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174199; c=relaxed/simple;
	bh=iTafF/5LaNjbcxE8OAcm8eXOnE8aLfbUTevQOqHr0AM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eN5aiKQWfpZDQkUOi1KCIpZAA461QtdOvewmoXWD0NRhPOaCY4G7ZE5MPZym/BAbBGBti4+hrn4nb6YxEJ1ss/uUk6Kgp+5u7Y0xr1njF70DmenP/w2u9C13v7mI8E1k1veUSlgby3AQN3xn+P+Zg5PY/h8Tfc3lJgR+XrKXfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=YpbA2d6c; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-210c535a19bso3064317fac.1
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707174197; x=1707778997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtZW1l0tMwHN4QHdh48s9EbJKUILTLIhCVQsN3Md67s=;
        b=YpbA2d6cQdh0diKS05sgrw6kHe7R05bT7sPrdKgZSbO6hzpGc8ItcZG4dm8mesciDC
         BbAGkcSV90UXLnlX/vMgdDiA1LNuv7b+vYzjE5EvFsS4cf0SZPZPEK+5JMYyT+yOWXRR
         6fmNQr2bgHqE7ibDnKIr3wyeoAq776ftYW0JQUcPmnCxAcZPrhk2DLtjyk22VtymTvpA
         0nJRe12oKJIR8f41GYjSiusN7+NmLfw0N3Crb4tdM7o2+dsPfKnIUfpi7DKdwOW6yNY8
         lkjacr+QyS1TcpuGX35J4QJqAnfkP5+sL18bAXnXafjq4XrZ1PlQ7y1ubMN4Q6Ao3yjq
         54bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174197; x=1707778997;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtZW1l0tMwHN4QHdh48s9EbJKUILTLIhCVQsN3Md67s=;
        b=ios2+Y/FDtCDUa3E/HktW6Zikbsx50tnlQ0NiIjsg21Ve5vBYGrgs2bqC6v0PONODK
         7LUSyQlNGtMiPZqQOSmiGB1Gh5uTU6ZizvXGCt/5Pd4MIQtcR9Ahdjrj6X9aD00Bawj4
         DV/Q5anb8DIw2/a46GgeVU2AGp7oKa7/yrmtnvTknI2RNJyCGQGJSUUZ0T0WTeLub9I5
         E/R+CNzBuRBojGao/RMinpImGo/YXxo/F+TPzu6pJ9IDmifCWwPUD3jDu4xjWCpmgwWd
         D4uCIVie7sVPIvAKWI8KVHWdFFFulUo81Nizmb5zfWlI9gcH1cblp3ZUdki0tCGG1B5b
         RwpA==
X-Gm-Message-State: AOJu0Yz7MKE5ivLU/wYwA5plWK1X3tBu7OC1oh8a+YSVtxjr95ZrtPTM
	d/VNq/+W1jyEw39eANzBT4hL3dhraVmgKjjThLxQjLTE5Gb1znDcZNPMR18MOb0g/fc6Yt1zPB7
	3HC87Tq5GYF0LPyMOqIm2Y2etqLeQlVnKnnsJ
X-Google-Smtp-Source: AGHT+IGmhpq0qgOo6A4n9dn9r0xjP8zEP+3uOp4g3/pXcE5NSrb5hxhHebDEVN6/GtPGmZz6mL3zcHjA8pOlc+s9wug=
X-Received: by 2002:a05:6870:171a:b0:219:3db5:b540 with SMTP id
 h26-20020a056870171a00b002193db5b540mr633669oae.41.1707174196790; Mon, 05 Feb
 2024 15:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 5 Feb 2024 15:03:05 -0800
Message-ID: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
Subject: The sk_err mechanism is infuriating in userspace
To: Network Development <netdev@vger.kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all-

I encounter this issue every couple of years, and it still seems to be
an issue, and it drives me nuts every time I see it.

I write software that uses unconnected datagram-style sockets.  Errors
happen for all kinds of reasons, and my software knows it.  My
software even handles the errors and moves on with its life.  I use
MSG_ERRQUEUE to understand the errors.  But the kernel fights back:

struct sk_buff *__skb_try_recv_datagram(struct sock *sk,
                                        struct sk_buff_head *queue,
                                        unsigned int flags, int *off, int *err,
                                        struct sk_buff **last)
{
        struct sk_buff *skb;
        unsigned long cpu_flags;
        /*
         * Caller is allowed not to check sk->sk_err before skb_recv_datagram()
         */
        int error = sock_error(sk);

        if (error)
                goto no_packet;
        ^^^^^^^^^^ <----- EXCUSE ME?

The kernel even fights back on the *send* path?!?

static long sock_wait_for_wmem(struct sock *sk, long timeo)
{
        DEFINE_WAIT(wait);

        sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
        for (;;) {
                if (!timeo)
                        break;
                if (signal_pending(current))
                        break;
                set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
                ...
                if (READ_ONCE(sk->sk_err))
                        break;  <-- KERNEL HATES UNCONNECTED SOCKETS!

This is IMO just broken.  I realize it's legacy behavior, but it's
BROKEN legacy behavior.  sk_err does not (at least for an unconnected
socket) indicate that anything is wrong with the socket.  It indicates
that something is worthy of notice, and it wants to tell me.

So:

1. sock_wait_for_wmem should IMO just not do that on an unconnected
socket.  AFAICS it's simply a bug.

2. How, exactly, am I supposed to call recvmsg() and, unambiguously,
find out whether recvmsg() actually failed?  There are actual errors
(something that indicates that the kernel malfunctioned or the socket
is broken), errors indicating that the packet being received is busted
(skb_copy_datagram_msg, for example), and also errors indicating that
there's an error queued up.

I would like to know that there's an error queued up.  That's what
poll and epoll are for, right?  Or a hint from recvmsg() that I should
call MSG_RECVERR too.  Or it could have a mode where it returns a
normal datagram *or* an error as appropriate.  But the current state
of affairs is just brittle and racy.

Are there any reasonably implementable, non-breaking ways to improve
the API so that programs that understand socket errors can actually
function fully correctly without gnarly retry loops in userspace and
silly heuristics about what errors are actually errors?

Grumpily,
Andy

