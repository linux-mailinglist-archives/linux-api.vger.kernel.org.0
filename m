Return-Path: <linux-api+bounces-3403-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0DA693A1
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E643516B482
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116031B0F1E;
	Wed, 19 Mar 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VHEtRE82"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC515A85E
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398346; cv=none; b=NpxTxc1zMn6bN8BNInhB8EuDpF3aO/PdC5UJ463FuhCOhfZrXIBim7zo0aAImbgtQbqAZvplNsX6M4ojik5NECt+SyHV2yHrMbkVZK1INDvzTyvPcMJUfQZrwM3TbNlYG+E/ay7uBayJVua82g18OE51X2xyCYouRMh3/Zk/+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398346; c=relaxed/simple;
	bh=DecHoeVvuZPf1798B6ofl0KEVe3MSa1ULHgC3f/pgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx7i2NuawnxN+16b4KHLvsIbPID8aR5Xx33hQ8bvOkritnQ15D6RO16ozpu5AZwHTSPjEP8qCibLxIbHP47witf7jKSylZYWmCJ5dOTRC3to3PQbJkCG922Pu/Yjd8DQSxxxXvVVWKEofYZM8WabWSAeZ0Xf4wFJaYwz4um42yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VHEtRE82; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so29968105ad.0
        for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742398343; x=1743003143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=VHEtRE82dpW80KhRY2ibVphmyZxSCwFrNEb47iibxNFEoqgYfCoeXH/9f1C+JxXAbT
         PkNtN2RH9ixJHgDd4g2ZrCjIHzNSfTmQkkSzMR6hR2OcmL3z96OUpkeVdVjnkLkJRjuH
         YqVxFgFMdB3x7wAuV0MHrb7qir5rwBztA8CPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398343; x=1743003143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=mhaXacv3ao6Pear7//7tEdBzMsSa2REV6SMWyo4ekl549+x7Gw3S/sZ9qWL+1Br6q6
         4P5j9/hDWvG0FmNT9B/ZeDONVrfFY/K3dhle5gYGHm6/lPgSh60RMgNFtAvn4eMxL9UX
         dGLGvh+ZTZH9KsEKRP7+aeSRki8wfEzy4t8+fJMK1UX4dZFajU8YMiaFuPLGIMg5rExI
         utvN6dWDP0OhOSUeVQ2YWs8XifKbs4DZECthaKjB+Q5bv45Wm9BpIeVw8P0+aHm1UFDD
         LPhbZPPIf0PgVUHtKWtQ7RV9ndNZSGDH6unisGF+Z9sNo54MmCCbfSs5AYtThxuzaGlW
         g7yA==
X-Forwarded-Encrypted: i=1; AJvYcCU7piQzO0fmnLJaAGxixnAvzpBoWggiJDHexrnIWgEF4bzloqGGn3Y3TEe1mQRnaK/iCRofeHsaEYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEklL6wSLyxlWdZ3jDpH4Kvs/HaQB1vEqcij+DDi2+jcVx4JiF
	eRmJvYjB2onKaBfE/QQabWbUkXeypEBV3VNCLQkT6UU/z3zM93noZwcadfiqRVE=
X-Gm-Gg: ASbGncuQUJHWHjEURUXFK1/XyE/59k656YNYPP21LrcpH1+ugktnnC4ZX9JdoaYZjEi
	I0pPxWDN0vtNgm6qopMVC5saLXhyMLTs/W7lHG8wphcpKnwWZSnWHjWTeTsQNEKU71JWuCD0KKZ
	fKDKflUwUobTCBx58CePW8MFvbmjeHQ53F7XKW1RCGBaF7SyIhsn+51SKVnYH15crPc0sHozed/
	o7nC/QvKErTNqDnwkVzIDJ513JIXJzo/pjJ96t6eEoxUAagaOMr/B6eCRY+x8ab6V5UlaWiIvSw
	OLc/D5CarFuvVBrCS3NkgFPKEyP2Euw/JAcd+3Kw3nDVPEfACm42aTpQphYXodG3buR22Qb2PXy
	iwjNjhEfp0hrag5j+IOT66xK4A9A=
X-Google-Smtp-Source: AGHT+IE928EvL/A0pSVSiRkpQ590uJxm0F/MyNYT3ARIPaWUxA9t+V2zDq6An5Z8ZPQuHl4hSSFFbg==
X-Received: by 2002:a05:6a20:a111:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fbed315b41mr5956837637.36.1742398343445;
        Wed, 19 Mar 2025 08:32:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96e58sm11106959a12.78.2025.03.19.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:32:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:32:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9p6oFlHxkYvUA8N@infradead.org>

On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> > One way to fix this is to add zerocopy notifications to sendfile similar
> > to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> > extensive work done by Pavel [1].
> 
> What is a "zerocopy notification" 

See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
sendmsg and passes MSG_ZEROCOPY a completion notification is added
to the error queue. The user app can poll for these to find out when
the TX has completed and the buffer it passed to the kernel can be
overwritten.

My series provides the same functionality via splice and sendfile2.

[1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html

> and why aren't you simply plugging this into io_uring and generate
> a CQE so that it works like all other asynchronous operations?

I linked to the iouring work that Pavel did in the cover letter.
Please take a look.

That work refactored the internals of how zerocopy completion
notifications are wired up, allowing other pieces of code to use the
same infrastructure and extend it, if needed.

My series is using the same internals that iouring (and others) use
to generate zerocopy completion notifications. Unlike iouring,
though, I don't need a fully customized implementation with a new
user API for harvesting completion events; I can use the existing
mechanism already in the kernel that user apps already use for
sendmsg (the error queue, as explained above and in the
MSG_ZEROCOPY documentation).

Let me know if that answers your question or if you have other
questions.

Thanks,
Joe

