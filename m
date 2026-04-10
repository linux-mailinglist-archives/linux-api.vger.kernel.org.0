Return-Path: <linux-api+bounces-6076-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCfOOpCm2GkhgggAu9opvQ
	(envelope-from <linux-api+bounces-6076-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 09:28:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6F3D3535
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64B973008D21
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A63A1A27;
	Fri, 10 Apr 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Erww+OFR"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB53A0EA5
	for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806092; cv=none; b=MPdM7ivk4c91DjeHf8QeXZDwahntq290b92L/C7v7YTSuFViONYe2Nb0CWj84qbr8yUeRfp/yXGzLIGmq05Hla6738+q0b8VH35wmw2kX/dxBYosEdrWCrnew8Jwmod4PTahRis5IYpVbP6c6CoxB2JA042OMdUlBu36tU04obY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806092; c=relaxed/simple;
	bh=KG3SX1YChb1ct+6zF6NR9IEGP7iDFBUiJqLUoPURypA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvpTiBp+LULisUZY/HGldi+bpEfspHHUO+Un0ts6Lfl6aUnAr5f7wPd8gcWE/vs6cy7DOBwkVy/gcv8wmViYAZZb0PZNs3FB5q5HEOSyb7qsJXFlqXxCXY2Z5GrdUQe/gjaXBaFpf/npM3pMRb6kgkgXrPJb/2OiG3LMFB/TcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Erww+OFR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wAD6x7ZHet8MHOjXGQZEBEeNflFtc66dfEcX7Gn2HpI=;
	b=Erww+OFRYV8yTl1imrZ0F/XO4uB8kdxE4B9K6myRmzduMAMnDEFls/3vqRSZdyfnTL1DNZ
	Br17aomkePS3OmLnxoUp/HL8U4hSRez/l/OVSoe2//0G7OH4AZuk5vYrGSMeX568uq2Ezw
	mrXJpFqRR9bFOhCrFljQ+Ed/Pp59YRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-brPOQarDOye-zE5p7smMSA-1; Fri,
 10 Apr 2026 03:28:05 -0400
X-MC-Unique: brPOQarDOye-zE5p7smMSA-1
X-Mimecast-MFC-AGG-ID: brPOQarDOye-zE5p7smMSA_1775806084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D85221800365;
	Fri, 10 Apr 2026 07:28:03 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.2.16.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD45219560AB;
	Fri, 10 Apr 2026 07:28:01 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: GNU C Library <libc-alpha@sourceware.org>, Alexey Dobriyan
 <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
In-Reply-To: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
	(H. J. Lu's message of "Fri, 10 Apr 2026 13:50:35 +0800")
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
Date: Fri, 10 Apr 2026 09:27:59 +0200
Message-ID: <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6076-lists,linux-api=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sourceware.org,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oldenburg.str.redhat.com:mid]
X-Rspamd-Queue-Id: 52A6F3D3535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

* H. J. Lu:

> To enable THP segment load, ld.so opens and reads 2 files under
> /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> /sys and is expensive.   Is it possible to put such info in vDSO?

Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary
vector a while back, but I don't know the status of that.

Thanks,
Florian


