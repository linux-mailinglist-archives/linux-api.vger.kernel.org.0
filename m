Return-Path: <linux-api+bounces-3165-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D70A2B492
	for <lists+linux-api@lfdr.de>; Thu,  6 Feb 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D931A1883D9A
	for <lists+linux-api@lfdr.de>; Thu,  6 Feb 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3310022FF27;
	Thu,  6 Feb 2025 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lgMqS8Fw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060823C395
	for <linux-api@vger.kernel.org>; Thu,  6 Feb 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879128; cv=none; b=iZEhGei2ItmCRIpMey73Z8F1lZf8/jQoZIIaBstm4Af8BfKzH1SbNkaC4/vut6ao63g+PeBjps++1aeiA28R7AjU2Y0NvSFWpDvFFPR3bYWYQNzu3yfuTSMrMbPwltFrlZp2aU/hdQuqwmsB2l0XkfdB7s/2Mxyp8Y6pvCNmD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879128; c=relaxed/simple;
	bh=PVuzEWiWGdU7/bhxXLzVugnQB2A6Ks+SP/VbQvRNZKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD49YGPd5NKQ4rXZVjmjVplmcLYO8absPq78Cyj4cfq1b02lvykvru2/L2zWA1MsSTAaiDvt+76KmNJ3/5y30aSuZwbHVAGUYxXgcxzxQYMLZ9N+ttRJ9Ix+T0qjmuH7W/U09jJ1Yvir8cWke0WDfdnvJ1Q3ATw2IKXlFOCtWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lgMqS8Fw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so29466405ad.0
        for <linux-api@vger.kernel.org>; Thu, 06 Feb 2025 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738879125; x=1739483925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9pEwEvQtMTht7p8WbC44bsRYNPMffSNDG4Pb5DVy/U=;
        b=lgMqS8FwYX9xWhM9kSZPql3Crx1UAQfys1VbpOJ3051C/p7QGVizCiPRKApgoLkAuR
         G1uHSk8GqayOBHbRg6VSPC5T/Ohvh5WHd+eQCimgke4rn5AytLk1I6IMf1UPVOyxRmBs
         nlz+hqo2I+H0DyWTcV6D4L5cwDE8aoWwp75bgiYDkHwWjbOpDS7Dbl+SnXeedEDRwUjZ
         9z3hq1QkloPVTh0K7qF8ICV8IrpZb8W+bvUCLsmNYUhKjhfGcSqaOIM06t5ZTQOoPRls
         d0ZD7i9Cpyu5kQRbVYyU246pK4CGvPklWVtDh/zqYT48ER/fGaisttKZ9futu9Tkqm8+
         Zq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879125; x=1739483925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9pEwEvQtMTht7p8WbC44bsRYNPMffSNDG4Pb5DVy/U=;
        b=vjTrrhAN+Bq8X4siZ4pkQ6J5jscI/h4i0jZYs44DQ2txvhcQBgqebU1H+wCyd0vUOc
         Z/v2GPoxIniMuVJFuOmz7qt5XlmNbr9yuNwU3Bm/jcF5KrfyC/jvS6wKTbRim7HIsyQa
         a+ANjdaXkzibHLtD/HlTFWIiMJld5fKx1KPF95ygId5noDNqzvn7OvjaqujJf/iwegup
         oMC/ieUUPOYgg5WcDDLahJAbXc6b0TsD5KlK29MeSlBH0KIJGvN7urtTOb3utHohhjjg
         JItBVawppBFGubUPtfuAa7Na3e/32btTpei3OHUXkhPd7J3c5QouY4G+ieSXlqjv2v5D
         ZHYg==
X-Forwarded-Encrypted: i=1; AJvYcCUev0MaJ013M+/ckXsIIUQaqjHD0rplr/fgmWH3GXNB9cS1oILQcBrGMWFUCQbLuUDeBMXIgQFIJv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgwKCgsjXAgehGdAgwFyfcQ+VXA5NQ+ZE6zXP8B2n0uZ0+ocL
	EkbQKJ5QsRs5PikJb2rBRNQyANx1ehTeks5nPw/VwK0mp9EwTRMbcXxKrTsb6qU=
X-Gm-Gg: ASbGnctKtmREwwCegyXF0adWWIZxejY2oi53UaMcBioh31QCoDDYR1kxGOJW4qspNCB
	6haZ/K1s3AZRYZOMScrNmBycTzjSI9kf5zCi1TPorpUDvhsJJmCYxh3dZpggDEzkt2lq4P6PiU7
	f1HVuK7E2IjguktSRI5ZoYTAng39NSx37MDandAwNadplKd8mNlVehFCyxyqQ2JTSFpk2HT+P9T
	6qmigVXSnlMIQ/AX3P+Vx24nFfG4cWA8yZ5pyPeF/v/j7ErcL0/ZiV4SPJ2w7Qtes8NTq77azVl
	lxhSTQ5v9y0FTfpCDLhQ0DIikw==
X-Google-Smtp-Source: AGHT+IEAeZdlOSa7aDkaxgunF100sJqK9vORD3h4QNYuoNX4V7Q49nJIgyQHGUMHbgK5Pow0L8i/Ig==
X-Received: by 2002:a05:6a00:228d:b0:726:41e:b310 with SMTP id d2e1a72fcca58-7305d48010bmr1263832b3a.12.1738879125283;
        Thu, 06 Feb 2025 13:58:45 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7c24sm1765047b3a.78.2025.02.06.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:58:44 -0800 (PST)
Date: Thu, 6 Feb 2025 13:58:42 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v14 2/8] Documentation: userspace-api: Add shadow
 stack API documentation
Message-ID: <Z6UwksPkdwb5DDcK@debug.ba.rivosinc.com>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
 <20250206-clone3-shadow-stack-v14-2-805b53af73b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250206-clone3-shadow-stack-v14-2-805b53af73b9@kernel.org>

On Thu, Feb 06, 2025 at 11:38:04AM +0000, Mark Brown wrote:
>There are a number of architectures with shadow stack features which we are
>presenting to userspace with as consistent an API as we can (though there
>are some architecture specifics). Especially given that there are some
>important considerations for userspace code interacting directly with the
>feature let's provide some documentation covering the common aspects.
>
>Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>Reviewed-by: Kees Cook <kees@kernel.org>
>Tested-by: Kees Cook <kees@kernel.org>
>Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

> Documentation/userspace-api/index.rst        |  1 +
> Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
> 2 files changed, 45 insertions(+)

