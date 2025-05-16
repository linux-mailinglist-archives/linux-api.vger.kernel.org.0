Return-Path: <linux-api+bounces-3784-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38800ABA055
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3F97A31E4
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EDB1C3BF7;
	Fri, 16 May 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="4ybJw8oj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="LuXTydbo"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D086359;
	Fri, 16 May 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410950; cv=none; b=Gcd/v6j1q2AV4K9FRjb7bDTPlqprBxHrXfNPrl9SoqUbzjOlqiwGLH9p6i0c20sSPS5fypEBOCMS8vKMz35X6VMC9NMg0TIM81NwcqLZSUyO762tu/kAW8WGEjT4AfejmiSTYvP1X7paboXEl0dK5gJ/xIicLaTOnqhWgJViDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410950; c=relaxed/simple;
	bh=yNBnVLcOaHsABXRiHTKzZpW8NFstzEg9JfiCqvlQifs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8AJLB5hD4g6e3udhWZuuxc5dzAaGbnWGENfktZImgrmyOy6shORFOerYEEKcVkUtHbUbx96F2NSVZqQkNqhM+CnJxuF89ib3N7EIjA/+EQPTMl+mxoZT6EyKcfweSUH1rEgmSu2XT4DSr/ecurfPd/c/tHFExp0KOoSq2MEvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=4ybJw8oj; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=LuXTydbo; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=XBz4QH/PBjKFFgEWZKy3AoIs5PRWkaATDn/TZf19qP0=; b=4ybJw8oj7FaiBM6Sj0I+f2h0TC
	gnhs/uvP3NCU+HtWgfW60TY2kmf+TlanRwitjOQg7yOiVB8AKFsVIVeyE/AQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=XBz4QH/PBjKFFgEWZKy3AoIs5PRWkaATDn/TZf19qP0=; b=LuXTydboU0Z0asTgCkhENIoAEk
	pGhtr/7K1YUB+czbnRODbzWFwINOmNGAHQWnz/FTxSfEiDWJsK1W6CGFmXQfELtGT5K5XBD+iCYkn
	rIrFRa5/JKjlHdETnKX/F5wBuyZ8KfyC14oTybLCD06Lc2lg60sAZzzXmNRub9l01AAItPI48mOYk
	drlvMiWiOfqdTXb6N2D6oLtD2fWAMaX/lBP8PMDmWHFk1Ti9wMd9D/0EIs6ZCiD5KMSekFwnt+p7n
	fgUY7XIGae1uocvEbmB8u3We8vE4z5j3pxpuVkMMTkKLr8dpQ0FwYngq+FOq88ve6iY69YOleX+c2
	Wavy65Ow==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uFxPS-00000007363-3I9f
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 15:55:42 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 0/6] tcp: support preloading data on a listening socket
Date: Fri, 16 May 2025 16:54:58 +0100
Message-ID: <cover.1747409911.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Support write to a listen TCP socket, for immediate
transmission on passive connection establishments.

On a normal connection transmission is triggered by the receipt of
the 3rd-ack. On a fastopen (with accepted cookie) connection the data
is sent in the synack packet.

The data preload is done using a sendmsg with a newly-defined flag
(MSG_PRELOAD); the amount of data limited to a single linear sk_buff.
Note that this definition is the last-but-two bit available if "int"
is 32 bits.

Testing:

A) packetdrill scripts for
   - normal non-TFO
   - normal TFO
   - synack lost
   - 3rd-ack acks only the SYN
   - 3rd-ack acks partial data
     (NB: packetdrill can only check the data size, not actual content)

B) Application use, running the application testsuite
   and manual check of specific cases via packet capture

C) Daily-driver laptop use (not expected to trigger the feature;
   only regression-test)

Jeremy Harris (6):
  tcp: support writing to a socket in listening state
  tcp: copy write-data from listen socket to accept child socket
  tcp: fastopen: add write-data to fastopen synack packet
  tcp: transmit any pending data on receipt of 3rd-ack
  tcp: fastopen: retransmit data when only the SYN of a synack-with-data
    is acked
  tcp: fastopen: extend retransmit-queue trimming to handle linear
    sk_buff

 include/linux/socket.h                        |  1 +
 net/ipv4/tcp.c                                | 17 ++++--
 net/ipv4/tcp_fastopen.c                       |  3 +-
 net/ipv4/tcp_input.c                          | 15 ++++-
 net/ipv4/tcp_ipv4.c                           |  4 +-
 net/ipv4/tcp_minisocks.c                      | 58 +++++++++++++++++--
 net/ipv4/tcp_output.c                         | 50 ++++++++++++++--
 .../perf/trace/beauty/include/linux/socket.h  |  1 +
 tools/perf/trace/beauty/msg_flags.c           |  3 +
 9 files changed, 135 insertions(+), 17 deletions(-)


base-commit: 2da35e4b4df99d3dd29bacf0c054e6988013d4ec
-- 
2.49.0


