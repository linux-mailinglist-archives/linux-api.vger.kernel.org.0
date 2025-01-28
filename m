Return-Path: <linux-api+bounces-3099-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE30A20D5E
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2025 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3B33A465C
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2C1D7992;
	Tue, 28 Jan 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XArRn0QO"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7F19DF61
	for <linux-api@vger.kernel.org>; Tue, 28 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079115; cv=none; b=hF1l9e+SClPvOtxJhE/A4C7Iuudin7jYjCVqNkvh7MSHKd7mLj2fmoK49u3y1/zaF/CWCXRRI3tZOKWQmVcnBsPZVbHAFfFri0a8dJE/ZDlr6w2dOtxsuQyhpw4pf1iiTveHGkbRaZnZr668okNYuQcVv2tv1szulBD5wgfJSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079115; c=relaxed/simple;
	bh=noXyBqI87BE5bKgzA/bkBi5QPBLeFamw8wGuZmVJ96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw5HXx3RoaaC5SY7gdzTSdJYbDBc2RNJNYprOPmHme8vhxgwCj0b9RNku1iFqUKNDZAjb/P47zyraMvTIBw1ZC4jwMzY4lp9kowcmNoHgf6f5DH9417HjeVjhWMtnTr6MnSDjV/lhdkW8RZTI2fa6ZadUqKoQL8HxYZEOvM5Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XArRn0QO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738079112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1t6D/PIMIyABHQaylKfMHsHw7I0DV8eA6V4Mnp8hC4=;
	b=XArRn0QOoNkWNYlgMaPaak8ulBSuyIq3D4Kd/NwpnPx8S776ZKISHMh4UL7ifIoqioTyfI
	AsawzjtoHQ7aqFcqa4Oye2dyUEfC+vgot0zBlHhM2BRQBJJP7ibXG0zTg67EVcAVG6QJMS
	JfUT8zcYD6yCGCLJTIsIInJnvZirp2w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_UDh5xabOfuNR0SA5QAVhQ-1; Tue,
 28 Jan 2025 10:45:05 -0500
X-MC-Unique: _UDh5xabOfuNR0SA5QAVhQ-1
X-Mimecast-MFC-AGG-ID: _UDh5xabOfuNR0SA5QAVhQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F7CB19560B3;
	Tue, 28 Jan 2025 15:45:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 88BFC30001BE;
	Tue, 28 Jan 2025 15:44:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Jan 2025 16:44:35 +0100 (CET)
Date: Tue, 28 Jan 2025 16:44:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250128154424.GB24845@redhat.com>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128145806.1849977-1-eyal.birger@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

can't review, I know nothing about seccomp_cache, but

On 01/28, Eyal Birger wrote:
>
> +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> +				   struct seccomp_data *sd)
> +{
> +#ifdef __NR_uretprobe
> +	if (sd->nr == __NR_uretprobe
> +#ifdef SECCOMP_ARCH_COMPAT
> +	    && sd->arch != SECCOMP_ARCH_COMPAT
> +#endif

it seems you can check

            && sd->arch == SECCOMP_ARCH_NATIVE

and avoid #ifdef SECCOMP_ARCH_COMPAT

Oleg.


