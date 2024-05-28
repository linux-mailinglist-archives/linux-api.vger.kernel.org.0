Return-Path: <linux-api+bounces-1641-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D908D1F2E
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D2E1F24023
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81A16FF27;
	Tue, 28 May 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G+uDRZb2"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718B107A0;
	Tue, 28 May 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907609; cv=none; b=LujmyeoC2PddgifHKgHacNoqITN9wr7q5R2FNTFXOIZvVDZgQ+EsPPwcqdpHWvTcXB6fu1+BBYOvzabyw3V/eLjNbNaJeb3mq1mYfQih1RjhznkiuU2BeP2wewAGwAiOA8ybXX0HgZP+lB8OX8aks5n2N8So1aXf+THkftAiLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907609; c=relaxed/simple;
	bh=wtEh5/u99fENnJNQrllCw9vLyimy2XrBJkj9B+2w+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxa//st+QbtZ8He6e4KQX0mRpj2Dd6lQqvNiIzWKQmhe+GKP+AQmYX5KVENZ9pzuDRQeBsGBENyiFEDEtJkfB/h6lx+NbAqEZG5nnxYuf3luk3cWSnXnxdgBAjKUKHEhtX7lrLIsT9pdfREgILJI51F9ePjrsXJpZ8GVC7+zadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G+uDRZb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91ECC3277B;
	Tue, 28 May 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G+uDRZb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1716907605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2k0ho4MdAkAbxz9sCr1vHlo4/ijHUp83UPCQgr4Fu4=;
	b=G+uDRZb280nWJknXkoFHDEKOAqThGHcsdPJF44P2i797gyiiegPyz6dQaj2Sor1BKuUe8+
	Qe36ym2cXQ2CzkjOD7ehtrwjoQyPDPd8EQ+SLTuf68hdRjhFM4aBEWUXTGegvdkk3bn52P
	pCKAFh4+0JtjehXmdZaf7MBLI3/oPdA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ece78ccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 14:46:45 +0000 (UTC)
Date: Tue, 28 May 2024 16:46:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de
Cc: linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 0/5] implement getrandom() in vDSO
Message-ID: <ZlXuUdPM6Fkik_cy@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528122352.2485958-1-Jason@zx2c4.com>

I've rebased Adhemerval's glibc patches for this and put them here:

    https://git.zx2c4.com/glibc/log/?h=vdso

If you're running systemd, you may want to whitelist the syscall in
order to make use of it:

    https://github.com/seccomp/libseccomp/pull/395
    https://github.com/systemd/systemd/pull/25519

