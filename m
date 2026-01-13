Return-Path: <linux-api+bounces-5636-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B14D1B9E5
	for <lists+linux-api@lfdr.de>; Tue, 13 Jan 2026 23:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C48303044B88
	for <lists+linux-api@lfdr.de>; Tue, 13 Jan 2026 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977933570D3;
	Tue, 13 Jan 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA2k1whL"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF9355057
	for <linux-api@vger.kernel.org>; Tue, 13 Jan 2026 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344069; cv=none; b=unxxehTL7zvxIBZfa5m1rIcg//ZGeBUn89FncwH6/M5dLN0+ZyshL2phuroCTc/43bZ76e3rUg6YJMR5pwtvne290uEkClVEtHWXltYd5/yOWzgWBnDeqn/HXSxVuUTA/3UjY5oBSZlUuU/SAVFDp6usVNq4RDZIHYQhbfJLQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344069; c=relaxed/simple;
	bh=6UO7RtOmPTz6IQwg8pbgCpoAZeNmofgqWMXaxtGQj1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYU5X87XpuxbLYZpU2rp0FVfUuWjvGDsSZatpE9prJOmRiCh1/ed7mq0/EtENi25L/921xMrhqkvmk6BhhTabJAIL1Pv0GKO5owXtmSFGg9PH2gjtoZBFi4K7204DluFVc1Zv4jTypqQR+w//TO2s9Cue9Yk60kFaVdsweiQc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA2k1whL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768344067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qykxqAbNrQoKnh3wHNIvgCs7cUxVfs/Z+IQXcKZ2nJo=;
	b=EA2k1whLNiPZujkJMnYMjl0558tSBVIphn7bg9BqU0M9lS1MjoRTMajf6Z8+QvdFTDdEw3
	mclFg18U7+522vescggQhaQatnd7Omsbix7myckWp952VopZxAuZiaJQzg9Ml9zPEPjyHJ
	sxZPNarzNfTUbA3zDlhuq5yCFH0ang0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228--IVogaX4NS6MTJHiQBq_XA-1; Tue,
 13 Jan 2026 17:41:02 -0500
X-MC-Unique: -IVogaX4NS6MTJHiQBq_XA-1
X-Mimecast-MFC-AGG-ID: -IVogaX4NS6MTJHiQBq_XA_1768344061
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFE1418005B4;
	Tue, 13 Jan 2026 22:41:00 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 404B330001A8;
	Tue, 13 Jan 2026 22:40:58 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Howells <dhowells@redhat.com>, DJ Delorie <dj@redhat.com>
Subject: O_CLOEXEC use for OPEN_TREE_CLOEXEC
Date: Tue, 13 Jan 2026 23:40:55 +0100
Message-ID: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In <linux/mount.h>, we have this:

#define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on execve() */

This causes a few pain points for us to on the glibc side when we mirror
this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
which is one of the headers that's completely incompatible with the UAPI
headers.

The reason why this is painful is because O_CLOEXEC has at least three
different values across architectures: 0x80000, 0x200000, 0x400000

Even for the UAPI this isn't ideal because it effectively burns three
open_tree flags, unless the flags are made architecture-specific, too.

Thanks,
Florian


