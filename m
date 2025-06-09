Return-Path: <linux-api+bounces-3884-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1EAD231E
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86F73B1136
	for <lists+linux-api@lfdr.de>; Mon,  9 Jun 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2B21322F;
	Mon,  9 Jun 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="In+alWvg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="n1GG/17s"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FC41C69;
	Mon,  9 Jun 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484619; cv=none; b=mPOrr+SjGx/hLQVv/3CSTineZRN6JhE7RDZ0NC3omTLmeSvR0odqQ1aNsRanImiUs5E6KWu18UQJjHLLSzKhwO2DLVpe9bSOSOhaMA9X7rXTbxOgJs+M3SAvsVJ4VYNVt9s9a+YVMEEJ88/CIKGUlzMDFvvepxqdzvkK8EtUQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484619; c=relaxed/simple;
	bh=5l5R7rNhHKEzEbQyFIgwgEzwNIoAODNy/3hPlogen8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKMbBWkScQcX9QaTFJcEh0hGqy6/aDUmX0AMNdLLNIwOosXrGV2nYP+iNx2J3ldl6Bs8STbu13pscf2h6GCTZUALnigU/HRdlhSM5Q5mmKU+PmWfbmr8xZZcnyd4+6QalxIXQGKKdrDT52PZv//1cKg4b0kqxY44br6tzr/zfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=In+alWvg; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=n1GG/17s; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=550YL5hpX5aEtseF56tLypzj0wnGdzzCQ/+VsW10d1Q=; b=In+alWvgmIimowCrQ7w09ARTdp
	qMC6v2oemuW0Jp9tgAKgWiUk6S5he+T+XB6weG5vCR5B0D+aSj2WJb3Dl0Bg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=550YL5hpX5aEtseF56tLypzj0wnGdzzCQ/+VsW10d1Q=; b=n1GG/17sNbk2+byBsy3zq/kDr4
	FYbhGFPKHFdCl5qWa2PxDo5ngrYFKBJeiV5cLlNDU8Ap1pmeQ+MtnFGjLk+yeoKZaXNdoq24qGYxN
	Bsps/Jokcwx97+XVnvtyrYJHXASlFEPiSMjAQxg6zd4Y7qgF8iY+R9L7BJPYXESt3sy/ay4FxtpOk
	4SJBdY7Tlb+yAHqbeXseRpRqpfvv7MldJGfx8FAm63azFyMORi+ohGXDvc/o6jyB0cGSF+rTGnxzV
	ClmsOdxUPwgVvBgobJkSvRa/OM++my43unOsAa8Qw76QIvfeCZTC0fxUGIWkT8+eT5b1D0um33dsU
	mBlu4Tog==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uOern-00000000mfw-1A9A
	(return-path <jgh@exim.org>);
	Mon, 09 Jun 2025 15:56:54 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next v3 0/6] tcp: support preloading data on a listening socket
Date: Mon,  9 Jun 2025 16:56:26 +0100
Message-ID: <cover.1749466540.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

I didn't get any comments on v2 apart from the kernel test robot
so I'm repeating the same resposes to v1 comment here.
I figured I should do a v3 to fix the compiler warnings the robot
pointed out.

v2 changes:
  - Split out the preload operation to a separate routine from
    tcp_sendmsg_locked() and restrict from looping over the supplied
    iovec

v3 changes:
  - Fix compiler warnings

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

   - enable_syscalls: "socket$inet_tcp", "listen", "sendmsg", "accept",
      "read", "write", "close", "syz_emit_ethernet", "syz_extract_tcp_res"

   - the coverage seems rather limited; the sendmsg onto a listen socket
     is there, but I am not convinced actual TCP connections are being
     excercised.  tcp_input.c only 2%; tcp_minisocks.c is entirely uncovered.

   - A need for limiting iteration in the sendmesg handling was found (RCU
     timeouts), hence v2, but no hint of locking problems.

     Eric: could you expand on your previous comment "I do not see any
     locking"?  If it referred to the syscall write operation on the listening
     socket, tcp_sendmsg_locked() is called with the sk locked - so I'm
     unsure where you're looking.

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
 net/ipv4/tcp.c                                | 112 ++++++++++++++++++
 net/ipv4/tcp_fastopen.c                       |   3 +-
 net/ipv4/tcp_input.c                          |  15 ++-
 net/ipv4/tcp_ipv4.c                           |   4 +-
 net/ipv4/tcp_minisocks.c                      |  58 ++++++++-
 net/ipv4/tcp_output.c                         |  50 +++++++-
 .../perf/trace/beauty/include/linux/socket.h  |   1 +
 tools/perf/trace/beauty/msg_flags.c           |   3 +
 9 files changed, 234 insertions(+), 13 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.49.0


