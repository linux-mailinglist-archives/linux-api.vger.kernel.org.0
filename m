Return-Path: <linux-api+bounces-6781-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w1T3EwYaTmoODQIAu9opvQ
	(envelope-from <linux-api+bounces-6781-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 11:36:06 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BA723CA1
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 11:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KkZc25gT;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6781-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6781-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 819C3301FCBE
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D741A798;
	Wed,  8 Jul 2026 09:34:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54633E92A0
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 09:34:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503298; cv=none; b=hkYfAnhUqr1KHpF/FDzZYE4yj1rD0zxXEb+aqJHRBqBuA+xxH67G1iI1qmAC3jVV+xZUH+DVA0WzUuo/OL1lrtbL5Xm+yXqtkyDeobXrO8cefxiNHd/CCglIf1y/sEYHGyK6VWGTX9SVa+TVlGeTr4KjJigaI6qLKTxa6FbRDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503298; c=relaxed/simple;
	bh=beVtjXrWuYofT5C9A2ZJDghifOTh4tK5f37wTOg0H/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIn+bwa72TLzqI6x1OhxN1nIcSnH81LMD3+D1bZrey5yqPxTWPgkGaaZ+IllkIxK+5yJE6i+8gy4NGt5fn5/0PPVTyHh43Or+F2GhqDgpJfZjaHJmrbc6OyJejEzxX+6/i9y8qfOUyJUTz2wqbUWsP4sD387WtpPzqdzTN9a6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkZc25gT; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LSGrhlD0yn8NtGRpP/yuLz9/lKXd3YZ5anjPExUEXbM=;
	b=KkZc25gTjMWRneQywrCnuQvrF9qgwQYE/zq6wsEEgnzKLeIeYPmx3MeVYlHNmCpxAV7ixF
	3W0alUYXj8ijw3a5sb+gRbgMf5JKDmwjwX2dOlwXGGeWeTrK/d7AWQcNNYBLMwlHa3knNc
	IKGgfB/zE7xxVfguPcjbNz+kTdKaeuc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-1jWkn7APP-qkLQEIcXgpAg-1; Wed,
 08 Jul 2026 05:34:51 -0400
X-MC-Unique: 1jWkn7APP-qkLQEIcXgpAg-1
X-Mimecast-MFC-AGG-ID: 1jWkn7APP-qkLQEIcXgpAg_1783503290
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391EB1956068;
	Wed,  8 Jul 2026 09:34:50 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAC481955F43;
	Wed,  8 Jul 2026 09:34:48 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 0/2] erofs: fd-based source and backing file introspection
Date: Wed,  8 Jul 2026 11:34:25 +0200
Message-ID: <20260708093446.3370200-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6781-lists,linux-api=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C90BA723CA1

This series adds two features to erofs for file-backed mounts:

1. Accept a source file descriptor via fsconfig(FSCONFIG_SET_FD,
  "source", NULL, fd) as an alternative to a path string.  This is
  useful when the backing file isn't reachable by path in the caller's
  mount namespace.  For example, composefs reusing an already-mounted
  erofs image's backing file.

2. Add an EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor
  to the backing image file.  This allows userspace to retrieve the
  backing file from an existing erofs mount without needing to know or
  parse the original source path.

Giuseppe Scrivano (2):
  erofs: accept source file descriptor via fsconfig
  erofs: add ioctl to retrieve the backing source file descriptor

 fs/erofs/inode.c           | 25 +++++++++++++++++++++++++
 fs/erofs/super.c           | 36 +++++++++++++++++++++++++-----------
 include/uapi/linux/erofs.h |  9 +++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/erofs.h

--
2.55.0


