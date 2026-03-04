Return-Path: <linux-api+bounces-5902-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NCEFrYKqGkWngAAu9opvQ
	(envelope-from <linux-api+bounces-5902-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 11:34:30 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82421FE695
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD55B31094E0
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2026 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458533A2545;
	Wed,  4 Mar 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhowHUW1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DA382F16
	for <linux-api@vger.kernel.org>; Wed,  4 Mar 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620145; cv=none; b=YpQXQa/WIdHZLz35w2hhy0uLkGP/r4vE8gA1ozaD+/PBjJ5XyG74q1BETkUwcbk7px78HUiZ2tfatvCpBQPEYoWFZu7WiZ5Nafii/OpdxAdmSLrHLSAFtzBOKAslIpbDaEJiLQcMGSZwQz4DSpD4GmY/1LJrx8iAwATiEXmwoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620145; c=relaxed/simple;
	bh=/LgUGSZMGY8uEem49KViRfs+8g+RfbwUJHSe6ipt2Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbHeoUiz0/tn1iF33x2ZNFzNETDgYwiT/JKW2X5QyVGwEQCd0Cf5TSIbHszun+7beI+oJD4E7d41kiVq3a1zJIfAPoSPHZmpzdMESxgW4xBjIe2DFgB7THzf22/uuoR5rEWUv40dm9pKHej0f6iS78yqkLbMKLTOCIt0CzO1w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhowHUW1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483a233819aso65491805e9.3
        for <linux-api@vger.kernel.org>; Wed, 04 Mar 2026 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772620142; x=1773224942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LgUGSZMGY8uEem49KViRfs+8g+RfbwUJHSe6ipt2Z0=;
        b=RhowHUW1rIRm7ZZ3sKor7KYqtRu81LZOc32xiRWptlwT0+nFWJ6Ls15+NwGD4CvTYV
         dUDH/FE6qXrQqLF8KO9TUM4T3z44utqGqgR0ocLNf981EWQHoAn+nldoQlKxr72Dx+SI
         UQKRUiWFaVVMW1AoYtu4j3+SF0JDR+lhLWEB03xjB5mqHnReziPTk9IHpJ1ucW0aj15G
         N5l/FGWiO+H7MR/ZQ93p+GkjZRdUF96SZ6kf8pUM36pqA6a7dutuY8RSd1zEXemu9U+A
         cLVk1/S6RytzfrPxJrmXELdG9Fb2dskBgUwJJriD8AHf87s2VJ/IezL9yXmmKgqmTbM+
         sRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620142; x=1773224942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LgUGSZMGY8uEem49KViRfs+8g+RfbwUJHSe6ipt2Z0=;
        b=c5lVYVSAO8ydwReM09kxKtWNhPWpFW7XdOjWHPdQz+1JW4/xqBqXw3k3FqVYxtHFkK
         GcftUVsqjvqX1ne0LlP9J6Gge6tesuAEb8xyGuUdJ+fNoUd/F2/bJby1gE2cJbbbPZsQ
         D+PHBYMk0EqY0JAl0V/vELNRWBD/3HfYOQp+k+HNGOkp76ORqVhG5C2GEzpa4WxBCB40
         Y021LY9NFDHOSwPoeyMCW6nU8Ib0HD2SI8qTNZWYMFAfvc0RVeV6czuFocHU04QDe7qj
         RnfK/QYqm0z576jgKCUoHduA9ICmIb4ngbiaP2OAHZQSNGkOncPcq/yMQJTukq1FZG8g
         9M9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdx8zflKAOaPQlprZtiYmtj9P249wslqpmylQ54/gZabdj0aNL/IB/c+LLjR0BMMrLGNTrRkwvUBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoE0EapmIgTJgz9Jpuhth7ZDYsQJtuDclbgP1q256gnnBBbIVq
	lfu1is/WrF4vIbbKmou8yDe+OnrmVOm44zgR+rW7fHG7ksZIuUtAybvR
X-Gm-Gg: ATEYQzzsEZL5FDpmpn3eGE091GgazebgbL1/LhDFtDeQGdnF7/JlqIo2J1tgplcDCoM
	TKzeVUYoaSWxzow9eUyzyvHLpsAplZq5POhf1mKbeXZdIeZylwUabI+utqTurcHN5aLJD1h7eZz
	kpE0QIsD6M7Nsy0ihBAYWWyh4bv3/ifiQ8CMCfHTzcWnWvPVMpM3mOeum8ssEyhz0n0phmH98Ff
	eDkP0Xc+hAZfZXlKM/gcokHRoPlLFtnZGOwJrzXuHyUX+hPVHtye9FCH89n71RhgyNkuzm2HibO
	AyufiSYpAJd9LbznGM5m6CgEFPa6c7y6ulQkaNrHqOcQbInq+XkYeUigszPT7a3+qyKVSjMP+wW
	PDdxvkgoKM4DTBo8A0GMeZbKDUf/u2YuZ2XB5QTWYJpzfkouioJ0BGSnedxqY20TuHgZScLLbY1
	Im+aE9QTsOjvYq0VTwQV4HtLJpny3xKlELl/9jJy8e1EXohDOxwjAv70kIjiZa3bZTCJm7plvLk
	aX9
X-Received: by 2002:a05:6000:2891:b0:439:b3d2:3766 with SMTP id ffacd0b85a97d-439c7fae450mr2692590f8f.19.1772620142349;
        Wed, 04 Mar 2026 02:29:02 -0800 (PST)
Received: from laptom.homenet.telecomitalia.it ([193.205.82.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c6129017sm5824734f8f.31.2026.03.04.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:29:01 -0800 (PST)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	linux-api@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/deadline: document new sched_getattr() feature for retrieving current parameters for DEADLINE tasks
Date: Wed,  4 Mar 2026 11:28:15 +0100
Message-ID: <20260304102843.1373905-1-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
References: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B82421FE695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5902-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommasocucinotta@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


Compared to the initially submitted documentation patch, this
version addresses the issue highlighted by Juri of the wrong wrapping
of the commit message, and the one found by the chatbot of the wrong
use of quotes around the flags parameter. I'm also adding "v2" in
the subject line, as requested by Randy.

