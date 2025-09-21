Return-Path: <linux-api+bounces-4904-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F242DB8E95B
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B3B3B80F2
	for <lists+linux-api@lfdr.de>; Sun, 21 Sep 2025 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A5256C84;
	Sun, 21 Sep 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpBxzyam"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE31F03D2
	for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496112; cv=none; b=B/zGKaN1T14TXnYyKHKWTISiRjE8BSWsjhLu5/1eGICZhwgsdz7vl82Fc3Gqy4Ftb0LZS4mO6FGJsAtLKKJIcHI5/uEuH3UJ8UvUmuqSumLCG4hOPDa5+dckMvM5FgOvLtcToLzdYm6cdF/9Rj0N/XezosbhhSKGtgJQ6mFffEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496112; c=relaxed/simple;
	bh=kp7sTRbvQCXDyuEv7lCMhx18j8NoJQstWz5bEdlO6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myln1Ka3iZZPsmU7dIKMSHTnFIC1xXkV/az90SL8Pm0MmT/wjOaEbwApENcy/KIqHuptcbk6IZR7kVWBwloKsu5ZXNEiJt9DZGJXxPTlDmZ4iFjroFnVHAFB768Qv7d/76IG8jZn0k7KS9cIWeaENYEOnaFmG9ZCGa4EjAF79Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpBxzyam; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2381c58941so491451566b.1
        for <linux-api@vger.kernel.org>; Sun, 21 Sep 2025 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758496109; x=1759100909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=TpBxzyamd3UoBsYuC7Kxvt8fyDLb5JWbAeYqjsLW+uE1kscQ8YDM0fE39a+IZJDj4p
         6FvQ6J3Y9eySk9poPZpSf5HrlBLc7dNhHUKSdTp8xGK/btqZtp8G55HthLKgzS3ivoJj
         CzHvMqA5TGUHWXoUCxHUAo7gse9eaK607GuXpAJ9SQijVj9/jvG8RbYJOe1v71Yrc+0s
         /VUNWWm8Pvn/qO7nNYSnXwK77iVE04NvWL/q5uJlMBRDVx8CA/t/StpdpYT2Wr1iuaGV
         W3fpq3NRoVVvKT5BzBBS2z/Nyj0SOCRRJ21eckXkrz59rmoZQdEjRDqadKWlgOkQg8ny
         lpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758496109; x=1759100909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=b/ZLWx0LqW3vju9PSpTKlI3H5WRU95a09fahoY/oKppAMuTP28FS7CoQdo72DYii6k
         MNP2PhkufIOEfmX01knGs1MXno/z88YnaVDPqVtXPEkJxlF0W3JPBW3JZ8/9E5omkoPD
         e2cW9FaD9Q2zjbfaA9zZdVGrzXO7bJp+Bf1+9t3d0aq34SyJjMWovT3XDrYUbdyqUVii
         XlA7uzy7nCI+KnaNNH6fjzKP2PuADy5zoQoaGQmBCIoriew6GWpyfrq1CiIPUNbKBlTS
         xZFMwDUnP4f3SIjz2fJ9xhyRZKrhKdK7SI72Ja30bc8LaGkm3+mRaLq2tdKVfaO2P3sn
         SSGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdP7fXBes0Y+sn0DQEV0rJA+Pc1RO0uolBC6Mt8VhgjFmDCaB2gZ1XC6pcPc7hGRFS5a8smiAVO4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzirE0lp43dRvFzebAPWM3jCzYG0H6LO2AXu4AzxHM/TNbw4MTe
	jRpxrdq09+JFUFqEAWcZYrOLpqIAZoXpu3GjI/EvfQTXsBb8UkkKVOlC
X-Gm-Gg: ASbGncu/y0GzhVnHXlBYAG/CuJT99lJh9nxbKgOly+UIsM+I/GsAELCMsPk9CnyfJNF
	oXiNIgFpeF5D0UPNjBpyyAO/mReXdNCSPlav1Kfa/lAZq+FmAPQkypZN8QnUcjNb/gvLwmI7IIH
	QtpmMUw9hT0VswlXom3QZo6RWxkMJY5hUezIGpTB4TqPGB8OvM56U2edTvghxYLeJzp6LRroKKd
	0QrYVj4jhiz4Nhi4dQDxXP7uj6x+5zOhVihmLChz/FWuD7y71ZpOCJmHYec4VtGYUd8SJ6v9F1P
	m5xOSYpNFk5zx3ZnQTRSsMxgKXT4Vd/ekq0C5xJpQ2xGt0CH/L7B6dgUa4RbUTOCw011BhPMYZo
	dKUIZWblKcLTKFUdoUYU=
X-Google-Smtp-Source: AGHT+IGaYL0rZYaG01O9JWNyxpX9QMFT7dX6PEZPc8o/39RX71pF0AyzIyHiFTeTuo7PDhxHHUV32g==
X-Received: by 2002:a17:906:6a19:b0:b2c:b12f:429b with SMTP id a640c23a62f3a-b2cb12f63f9mr126937766b.62.1758496108686;
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88badsm941730566b.52.2025.09.21.16.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 02:08:18 +0300
Message-ID: <20250921230824.92612-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Note that the unmount operation on close(2) is lazy—akin to calling umount2(2) with MOUNT_DETACH

MNT_DETACH, not MOUNT_DETACH

-- 
Askar Safin

