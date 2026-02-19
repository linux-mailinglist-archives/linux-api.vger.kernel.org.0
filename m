Return-Path: <linux-api+bounces-5865-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEDgNRahl2nc3AIAu9opvQ
	(envelope-from <linux-api+bounces-5865-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 00:47:34 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B909163A97
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 00:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C951A30E56A6
	for <lists+linux-api@lfdr.de>; Thu, 19 Feb 2026 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807232B99E;
	Thu, 19 Feb 2026 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfQcgfQX"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E19326D6B
	for <linux-api@vger.kernel.org>; Thu, 19 Feb 2026 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544580; cv=none; b=dRMJmVQAwpre/Cidq/AI85BL0wHs+J0WTgLOaENFNCFpZk0snpjohinCvm3Jk0N30b7+E+m0lQ0GXNXzs3xqvAH1SE0h6YNqLltYwzIRljOPmJErEOYG4nfmFhbn9UtUNDZuRxU/XdM+AoPojwIPyo55rSp5Bhr90R0mzm+9x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544580; c=relaxed/simple;
	bh=quE5sGl3Uk/gMNmwDYmHMacZa/Zg+chR5zy0mjgEh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgkkghBPAqc8GJ6Ug4kvpHIBW+7DH7IyWnJSbeWoOysD9eCk2EvOKXsoG8iuLhBUb+CQHXd2xKMtelA9Rd5CLa/h8Wo4AiYwdRFXHVexKUttvZ65i01EBVAxIfFtKF7IVmPm/neM2ihPqSRqm81y9El9H2+O1LGdpGVNGw66CYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfQcgfQX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483a233819aso10176825e9.3
        for <linux-api@vger.kernel.org>; Thu, 19 Feb 2026 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771544577; x=1772149377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=UfQcgfQXQy+pYZ6LXrr9RBMeLnuzdqzm13XEFaa5QkNWUZcmJ241fUUe8Cqas9iInE
         Rx/OLeqATRTaT9UFghx2R2YUrh60VeM9q1gBCqVQKa9U+Jxprjj4tj6sov/A/DnjhP2J
         zOS1DfxoNfNg3j2OOVvKMCb/Xzyz+LhmQsyNb0TNhUEkus4xluqIIQIX6Eua36gAiYmd
         LLD6KyKE/dY94xjs0z4jy+o9yXlTGvuVI1SBZGDoisBPmF04N9gUlhqeHisj33IaXNIi
         gLSVGbUIGlvaAYq3drOD5i99jhPZhetE15bWfy/5E5cl730+9fQFX2m5YUnv8bs5qdcm
         rA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544577; x=1772149377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=bJA+Wo5QbfoNv6n3kKR+AtXuZ+H5uG0xnACIi0s71H3ctTEmoD0nJSh1jyThmdBdhD
         PphmBEs6dslzWzE3K8xPvaktUjVFqsGnS05TkBlzAsPNrrKtyFCFjRExFI27zBDH020u
         RcYBbT0foaE9K1kcN2ShYUPrjCURIAnUSr02xAQZ+g0QPsyXRiz+OsDOFGvzlT+f0/R5
         SRb5+StIX3XDwkmUMUMpVq1LWgnRNwM7e25vg6fTvtaRgVGSYDigHS2GdrncgmA1K3MH
         yrKkQMbQ6OZUhu3QhDRuc0VXFC1BmOVx7T/qSIXT+XJvqC2nlpvSGnTQWQsW+NeSgveh
         sSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1hmhaaZmSCs0yZwI6PF4VLGVxudkgA5bUe5nEaubQx+XnfppUnyltF0iY/6hu0nLGJtPLI634ptg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEYGx5FdiE1TAZUDc9es1McaQCbU3mefCvNI16G2PhtJOzbg0
	XmpjaT3LjSDSrGtuRBiBq/EMqRTrtVL6H8i6J0002A5HyghNArOm0RXP
X-Gm-Gg: AZuq6aKJ/PzSd8x+cWC4g997E/WFGicq6PY2BP3eDoHgryiveKKzDzoKra4K2f1y5iM
	1EBspS0BaF6JQq7XlSLVSr+byf6tSsIVDHgWWLDkji0/vFTQpghTTgwlTrJnCWeUMQkbRyJKD/L
	GSD3n2T4v4wbGIt5EfGpB6fWP01U/yRLecBtZ5IBqgaks5q7Y0OWfbTaSbj1e99QQN/cB63WYP6
	aj7mHs43at0AW/MZzjrahLU/P0amHYxlqyD5GG/YNLJHW15a/xAGLlZBoiMxc83qoX8gVoSb9dw
	fkKB30eGS3EvbUeA3eBE8z+TwpQLodx+tSSq26vQzLWcELjZ36HKcOnaZMzImMnnUkL6mT0TSWf
	F3fzREU7qHcgXtxx089aC7Jxjpruxhj7EhN4rUjCOElXzoRAYG60WUpBikqZHZLlbBsn8P5j/wb
	AvwywHiw1A5TTr7igLgiA=
X-Received: by 2002:a05:600c:4e54:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-4839c002d65mr111614985e9.35.1771544577127;
        Thu, 19 Feb 2026 15:42:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c048bsm35793735e9.7.2026.02.19.15.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 15:42:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: containers@lists.linux.dev,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Fri, 20 Feb 2026 02:42:49 +0300
Message-ID: <20260219234249.3757808-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
References: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-5865-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3B909163A97
X-Rspamd-Action: no action

Rob Landley <rob@landley.net>:
> Also, could you guys make CONFIG_DEVTMPFS_MOUNT work with initramfs?

I did something similar:
https://lore.kernel.org/initramfs/20260219210312.3468980-1-safinaskar@gmail.com/T/#u

Does this solve your problem?

-- 
Askar Safin

