Return-Path: <linux-api+bounces-3835-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F6ABF352
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40DC3AC310
	for <lists+linux-api@lfdr.de>; Wed, 21 May 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C93526561A;
	Wed, 21 May 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="Aor6vcDK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="Monvn6qK"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546526461B;
	Wed, 21 May 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828203; cv=none; b=FsyKlLyUuZC5VqxZH2A2nG81ktUCpUaeFDtOYw5skwol0D1W3oyeIq/HdbYnvEVSxC029gi0jkFz+3QoimUpkZisrGXVr9baTJSOgoKWdnvjBw5tP9aKDK0vnOOMt8vfhv9j+wTh7z9R8UiOYex91d8EIx7buJUdMagx45nvsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828203; c=relaxed/simple;
	bh=94NKlIOM338OSq+CvmTZLZIeiiOYjMuldoOadqiH5aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ideoqt6vaSpOKKpOORXVK3dPzPGwrpawP70kVzfoUV4iEEF2AszGBMEpw4pRfA7CZihIcoZf9u5i4E3oXywmJ0U8K9LmXEX/+u2M/rBamZZCUJwl0JypRzHp/f/nlCR0L4RuyUNebIlfZyisBZBpHrJBAc/DXVP4D86k8H0WWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=Aor6vcDK; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=Monvn6qK; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=/IJ6vO6nhMTBgy4Lv/wEdB9z5KQX1Rv8gmCE+6WeMWI=; b=Aor6vcDKhss3oabp+nfpcotSjL
	oxTOEP7vFn8tehhlAzqT61gQUUYtbU/YS8mi8Z9wB01NhzvZ4hn0trB024Dw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=/IJ6vO6nhMTBgy4Lv/wEdB9z5KQX1Rv8gmCE+6WeMWI=; b=Monvn6qKAvJyaSxfm+xmWbTpJg
	q27kLj/YUgVjJPFR/NQiCqmhG0IcXRHRjzLKwNlMNbBfW/FhMtdCzxfRlPjjU4wnq/nC/tP9Wx62j
	kbt1YGXD7pdoCdhS3DO0pxPQneja2dPPbtjVPlAAIkZ28pRki75mdt2pSN+9cWlrRCrxK+qFMfYWD
	iR/WK3wMjHK64An7DFyyANowAsbu6MVMETvu0Ca7ggd4/q2DfoGPtXRQ2E5N8c5CJ6qC3qoymHcfx
	jCOoYg2fmq/rRxrbeDjep4GKDc4mIhoS+jt6fSFfSQNWM83w7aF0YxZRjMF9Ik9Pd5aPOh5XOlmNT
	FzvUA0sQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uHht3-00000001yTm-4AAH
	(return-path <jgh@exim.org>);
	Wed, 21 May 2025 11:45:30 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v2 0/6] tcp: support preloading data on a listening socket
Date: Wed, 21 May 2025 12:44:59 +0100
Message-ID: <cover.1747826775.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

v2 changes:
  - Split out the preload operation to a separate routine from
    tcp_sendmsg_locked() and restrict from looping over the supplied
    iovec

------
Support write to a listen TCP socket, for immediate
transmission on all later passive connection establishments
parented by the listen socket.

On a normal connection transmission of the data is triggered by the receipt
of the 3rd-ack. On a fastopen (with accepted cookie) connection the data
is sent in the synack packet.

The data preload is done using a sendmsg with a newly-defined flag
(MSG_PRELOAD); the amount of data limited to a single linear sk_buff.
Note that this definition is the last-but-two bit available if "int"
is 32 bits.

Intent: lower latency for server-first protocols using TCP.
  Known cases of this use are SMTP and MySQL.

  Measurements:
    Packet capture (laptop, loopback, TFO requeste) for initial SYN to first
    client data packet (5 samples):

    - baseline   TFO-C      1064 1470 1455 1547 1595  usec
    - patched    non-TFO     140  150  159  144  153  usec
    - patched    TFO-C       142  149  149  125  125  usec

  Out of scope:
  - Client-first protocols
  - TLS-on-connect

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

D) KASAN/syzkaller
   - enable_syscalls "socket$inet_tcp", "listen", "sendmsg", "accept",
      "read", "write", "close", "syz_emit_ethernet", "syz_extract_tcp_res"
   - the coverage seems rather limited; the sendmsg onto a listen socket
     is there, but I am not convinced actual TCP connections are being
     excercised.  tcp_minisocks.c is entirely uncovered.
   - A need for limiting iteration in the above sendmesg was found (RCU
     timeouts), hence v2, but no hint of locking problems.
     Eric: could you expand on your previous comment?  If it referred to
     the listening socket, tcp_sendmsg_locked() is called with the sk
     locked.

Jeremy Harris (6):
  tcp: support writing to a socket in listening state
  tcp: copy write-data from listen socket to accept child socket
  tcp: fastopen: add write-data to fastopen synack packet
  tcp: transmit any pending data on receipt of 3rd-ack
  tcp: fastopen: retransmit data when only the SYN of a synack-with-data
    is acked
  tcp: fastopen: extend retransmit-queue trimming to handle linear
    sk_buff

 include/linux/socket.h                        |   1 +
 net/ipv4/tcp.c                                | 115 ++++++++++++++++++
 net/ipv4/tcp_fastopen.c                       |   3 +-
 net/ipv4/tcp_input.c                          |  15 ++-
 net/ipv4/tcp_ipv4.c                           |   4 +-
 net/ipv4/tcp_minisocks.c                      |  58 ++++++++-
 net/ipv4/tcp_output.c                         |  50 +++++++-
 .../perf/trace/beauty/include/linux/socket.h  |   1 +
 tools/perf/trace/beauty/msg_flags.c           |   3 +
 9 files changed, 237 insertions(+), 13 deletions(-)


base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
-- 
2.49.0


