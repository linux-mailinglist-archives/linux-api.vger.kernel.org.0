Return-Path: <linux-api+bounces-854-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8584BBC9
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 18:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB221C23496
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7136FB1;
	Tue,  6 Feb 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="b1AzzDn+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA5D51E
	for <linux-api@vger.kernel.org>; Tue,  6 Feb 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240300; cv=none; b=lDnK39B3xK9XZ4S/JjLYR+AfxcoeJ5IHhukwfXadxrX1fbxCfuvd/64ATgOCZKGfopHvcT5CLE91rjmMNxgP/+9g0SMIug/tnnGgEE2ksHvnKSsOM6/vym4Jq/NGZinJhYJr2XDVYNnv9ZXAitT7H9Y5wNjGtiPo5j7HgA9M8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240300; c=relaxed/simple;
	bh=h8xOO95jCVy0Rr1WdvH+64TVszy1Zcsy0yDaXKgU5Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvvFrJrULnpAN5UpBay7nWREez3d8r6gNrwp2FLac+N4h+F4ym8IceKnFPNMp1LdvM2cLVbMGtu4xhITIXL13Z8XGnuj67MDZLp0kTzwR6TtyTu2LBnUsrcjPZ2xoPcfxLgfu7zvFpK4PKnSF47c7q3brD/xEWZTisx0s7jcoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=b1AzzDn+; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c02be905beso819329e0c.0
        for <linux-api@vger.kernel.org>; Tue, 06 Feb 2024 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707240297; x=1707845097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIzcSD9Xq+O5PETXD7ZTRHSCXOme/sQrEKE0wVFuRRU=;
        b=b1AzzDn+QWsFAEZtul5WFsx/C5RUQcx9ziP1U7aFxQ0iwwZPpxEjj6EjRU76Eg8FsE
         FOnxqZN23Fxlefnbc1Qh7CdyVXFE22iEh/fAzCpLDVVz93wAorcCCQcWWLFavr+p8zEv
         YFxKf6S8km4tK8C1KFoig071p7NsYiYiIg1Qsias5MguNH8JKn94eGErzY8Cc+rPzARg
         wM7dLBjGiknjoomRmFu13uFj9JMRfIeltsQrtNNnl+BXmbvUjKdE7A/s64GlsTlhhZWO
         yuZJNPLYygO4cXKd0OFz4barhQ5kFFl8pdQXY3/1lHlf9xqbJgeBoM4i2L+gbVOYQshj
         QbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240297; x=1707845097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIzcSD9Xq+O5PETXD7ZTRHSCXOme/sQrEKE0wVFuRRU=;
        b=doH3SxYnWjZmAPvaKvayCWXEglI0lO0m5OpQtnnHU1cj4fMcufFf6NUBUzWRyj7FfR
         yJqeEfY7HN7nYXSciOkl2lDQVebf53rRDBh74hK3AJwpyzNvB74ffqPX4PoPEU/yaTHi
         zFCcM2FZoMUr/PatbtDsjwyikxsP+sE2Ud7oqvYHhFa/XfePxXIZiuRxQ7ydiV6NHl4v
         gMkhOqigumIG/0Rnu9TC2FMTAGCplBUC6D200CeirBKWRqsGo4ARwTnbS4aE/8r3gx8Y
         i0O7UN0MLK4/fJ2ZdOCp52Qj5htzaOTUqNIS/rJY4baBYtj1B5EuP2LhRU7JsBhu76Z8
         JMTQ==
X-Gm-Message-State: AOJu0Ywyoz090m6pUiHJRjM+8nhOSUM7C0TCQv0SVCwUBywh8ni5t/fO
	rcfnhb9g2s30kFO5ZxUK+35FvpXVXmud5Osyb4Sk85yzYNJAK1NPzIqUSuQLbLgIgngbUUlSvTg
	Itht935SJTekJHqKYvUhPMXlc7zH6UDW3mNwIBTbh3iSTzqYh/Q==
X-Google-Smtp-Source: AGHT+IF7+v4LURbyg1/ybXH31ajB+XF+II0FobTXLWAIg5+nVbLNSWG2FUW/7lWsDMvDD8FoIu7avjb18yLSgXYwcQY=
X-Received: by 2002:a05:6122:4306:b0:4c0:2416:6fd0 with SMTP id
 cp6-20020a056122430600b004c024166fd0mr217508vkb.6.1707240297184; Tue, 06 Feb
 2024 09:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
 <852606cd9cbc8da9c6735b4ad6216ba55408b767.camel@redhat.com>
In-Reply-To: <852606cd9cbc8da9c6735b4ad6216ba55408b767.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 6 Feb 2024 09:24:45 -0800
Message-ID: <CALCETrUZuhvR3GygBfyfLxeas+igNe51Tnx=HEnh9LoFutN-dQ@mail.gmail.com>
Subject: Re: The sk_err mechanism is infuriating in userspace
To: Paolo Abeni <pabeni@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> What about 'destination/port unreachable' and many other similar errors
> reported by sk_err? Which specific errors reported by sk_err does not
> indicate that anything is wrong with the socket ?

Destination/port unreachable are *exactly* the primary offenders.  Consider=
:

1. TCP socket.  If the peer becomes unreachable, the connection is
unusable.  Maybe reading previously queued data is reasonable; maybe
it's not, but one way or another the connection isn't working any
more.  The current API seems okay.

2. UDP peer-to-peer connection.  I have a socket and it's connected to
a peer.  The peer sends an ICMP error or a route changes and the
kernel can't route to the peer.  The connection is at least
temporarily dead.  If we accept that temporarily dead equals
permanently dead, then returning errors codes makes sense.  Even if we
expect the application to try to recover without making a new socket,
telling the application seems fine.  The application will understand
that an error occurred communicating with its peer and can do
something about it.

3. UDP *server* with multiple clients.  (Or unconnected UDP socket
communicating with multiple peers, etc.)  Imagine a DNS server or a
QUIC server -- I hear QUIC is cool lately.  A userspace server has a
socket, and it does sendto() or sendmsg() to a whole bunch of
addresses.  One of them sends an ICMP error.  There are multiple
things the server might do.  It might ignore the error entirely and
treat it just like a timeout, because it probably already has
perfectly nice timeout handling.  Or it might want to know that there
was an error communicating with a *specific* peer and release
resources sooner than it would for a timeout.  Or it might want to
collect the entire ICMP error (via RECVERR) and do something useful
with it.  But it gets no value whatsoever from knowing that an
unspecified peer sent an ICMP error, and it gets negative value from
having a call to recvfrom() or recvmsg() fail and needing to look up
in some hopefully-correct table whether the failure indicates an
actual problem (EFAULT, for example) or a completely useless return
value that should be ignored (EHOSTUNREACH).

(#3 is probably worse if the application uses one-shot notifications
-- the application needs to make a decision as to whether to call
recvfrom/recvmsg again or go back to polling.)

--Andy

