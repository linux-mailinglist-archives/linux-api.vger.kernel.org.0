Return-Path: <linux-api+bounces-4748-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE4B5421F
	for <lists+linux-api@lfdr.de>; Fri, 12 Sep 2025 07:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358281BC3AE1
	for <lists+linux-api@lfdr.de>; Fri, 12 Sep 2025 05:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39226B942;
	Fri, 12 Sep 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtBuGFQZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43B2727FA
	for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655587; cv=none; b=J+RysV9dk7s1gE1GflccjrJwtrrd7TBTzBwx6e2tUZoKpBvd6gFImzauOkU519n/5BCLE1MyRcsaVNnjsABIZ8ME2FEVSzAi/Mo3SDPvo8rB5vQyxsDcPj6RkDQzfRUNieC48Vae93kPF9AwSUhM3L1wM3L602tsncf5H+q/y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655587; c=relaxed/simple;
	bh=FE4LEfa0MFWh4XVO+HcjVeFJCgM/7FC5uvlRFWH9I8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hX4tFaPf99laCdce7N8+DhUOglYzgpioyD9tv18QDWefFvQ6RJCRz/KXbJS8qeKyN8edVFShJU08RwWlPtPgKl+8dkJt+7YjD0IR5RIK5dotJIahePOq2dzI8tEmOUCGY1vgzpefO+gLUET03SSIt7raDO/vJPCKDr2sd8g4TL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtBuGFQZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df7ca2955so6899615e9.3
        for <linux-api@vger.kernel.org>; Thu, 11 Sep 2025 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655583; x=1758260383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hM2DWLFWIwZvGeYjqfMb7Q47eznE2Jw4O6GSXIWsUA0=;
        b=OtBuGFQZWfSakL0ZrkWP8l7Q97BBOLa5Y6HnC1IuCiH0Bi3T0J8LHyAI61zTLDNPOo
         NCYAt9ac8yx9GIg6plUCvnsKdHVTeRUGRBFQtdIWOiR0FhrKgXV1t0X6d2AQxtEpV/Ua
         5u8T/iEaU2H/5hg93oKf+KZCCGMw0UvYTYOk/pmZ+OhejNpOYQLNJbzT0o+mEEHgX68A
         a1y4PLDJxyoInM9sFYcoeLYIDpjb5AtxbBZ8gQdqWf1BAMHV4L+L0U5FBThmHgpTzfH0
         sikMBTnk+TVX3DR4ae141UWi9LMSLwhWVvfnI5soHBFMwBinx+IiXR41lkQnTHZMAq+8
         37JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655584; x=1758260384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM2DWLFWIwZvGeYjqfMb7Q47eznE2Jw4O6GSXIWsUA0=;
        b=IbhOJ00oC8O3NANmSnQ7wSxbl/FAbK8A2vScvgsv+CcXYtJd9U1AnDVUciJv6cgBeM
         3AnnXdPguINkbdWKJjJzhl9KqHaSkcPPS4A4TUssjNr95bTsUoeAmBCwFHAx0DJuE8Ln
         KoS82MTzZ8ebYeRR8RbtVRewiR6ea0FHl6RmHEYBWFERwLHwCCtlpw1CnJO5e4+t18Hm
         ZCKvI9MYcJCshBPLw1a6KduSX8MriofXCZFFOsGgJ5M7j6sFGZfgBXzaXjeXHE99Rmqm
         rKI4o6mPcsIVG9nFrc0Vn9opnqortk4vfkFmJTFwZ1n+5LQ+Xnqfb5h4GAcnhNq/rXuL
         gElw==
X-Forwarded-Encrypted: i=1; AJvYcCU0oHBcPb81dSWeiXgf8XmGIZEXylNR5vT6IVZgFO2n93TZ6rluGbmCwv/vycfKDCpeDbpAvAxCR1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlha+ATw/2qn+v4JhTnQCoagr3nKK5FFpyFR3UEIfwWLVv2MeA
	aC/7tFibdu/xaOZlZ+M6DfVvyy28vhlF0KBq6Md2z8dem7Prjlq99DCj
X-Gm-Gg: ASbGncvzhzsSzNRr7KI1cqMEI1am0JJmC5ruULrd07WLRoUMizrK0vuXl2la/iomKWk
	bekSvtH6hnJpeDNxvFZRf8rHPttmaovYfWfPsSDpTfbU03Mk/HCKyw7MQS7vSkzhMq+vs1RJtUx
	RPKriAyCU9FlhqIpyl+aA8Vc6Y59LO1BsmGpv4QTQYIAwyK9haxNzQBmoKG4qAmZnFPy/P6vSfI
	YJQA24c3NndRv/2KThtWEQpEPmQmwJKzFu1OMeVeFY5CG9IBHNZ70HjqXV7XrrrdsTzGHa4eV8u
	C4BFjvYusqFY+WMSUK6AJZsU8UR3aMOkgyGyAmolTCM8UeX40CEcLCjeUGk6NWvU77HqEQBBoi0
	qywxHYOModEQee5PicA3jmnXyYd4+H7ysJtkBA85ANAwsj7h1R2WP4BEbZHZ5f+N1pQNI9mDPjt
	eQiA==
X-Google-Smtp-Source: AGHT+IHRrddtK+Ata6mD2381zASluGACziWU1VzEvaAee09SitgxP/yhFsAZ6KBSeSxjyPaJqjpjiA==
X-Received: by 2002:a7b:ca5a:0:b0:45d:e0cf:41c9 with SMTP id 5b1f17b1804b1-45f211f89d6mr11529475e9.22.1757655583416;
        Thu, 11 Sep 2025 22:39:43 -0700 (PDT)
Received: from laptom.homenet.telecomitalia.it ([185.92.96.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd27dsm5032925f8f.41.2025.09.11.22.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:39:42 -0700 (PDT)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
Subject: [PATCH] sched/deadline: Add reporting of runtime left & abs deadline to sched_getattr() for DEADLINE tasks
Date: Fri, 12 Sep 2025 07:38:28 +0200
Message-ID: <20250912053937.31636-1-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm resending this patch proposal after having addressed a few Juri's
comments, and a rebase on top of the post-august-break tip sched/core.

The SCHED_DEADLINE scheduler allows reading the statically configured
run-time, deadline, and period parameters through the sched_getattr()
system call. However, there is no immediate way to access, from user space,
the current parameters used within the scheduler: the instantaneous runtime
left in the current cycle, as well as the current absolute deadline.

The `flags' sched_getattr() parameter, so far mandated to contain zero,
now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
retrieval of the leftover runtime and absolute deadline, converted to a
CLOCK_MONOTONIC reference, instead of the statically configured parameters.

This feature is useful for adaptive SCHED_DEADLINE tasks that need to
modify their behavior depending on whether or not there is enough runtime
left in the current period, and/or what is the current absolute deadline.

Notes:
- before returning the instantaneous parameters, the runtime is updated;
- the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
  in CLOCK_MONOTONIC reference; this causes multiple invocations from the
  same period to return values that may differ for a few ns (showing some
  small drift), albeit the deadline doesn't move, in rq_clock() reference;
- the abs deadline value returned to user-space, as unsigned 64-bit value,
  can represent nearly 585 years since boot time;
- setting flags=0 provides the old behavior (retrieve static parameters).

See also the notes from discussion held at OSPM 2025 on the topic
"Making user space aware of current deadline-scheduler parameters".

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

