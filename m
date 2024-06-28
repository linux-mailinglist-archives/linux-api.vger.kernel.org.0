Return-Path: <linux-api+bounces-1804-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142F91C08A
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8690DB214D0
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BE1C0068;
	Fri, 28 Jun 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gml5pEvC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46A1BF301;
	Fri, 28 Jun 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583883; cv=none; b=okUVpInfn+dR+wNFTg77unNp56IuGhwEl7VKbCJw3W0vRCyy2V3wXklczDs+BwtMvVm89TNi23Xg35Tb0Un8AKUxc5oKZHXe6hsHFj7Xa6A+6l5ZeJp4i9pPjVapjsalsJnpOFH63RDNlUl73lcrnEO08SulEM6QxREmZkZX5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583883; c=relaxed/simple;
	bh=kiBm5EREbGVMfrUkvJrKTbweEBAPn9IDvv8OAj+0kdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLQLCmguaCbYdxEKA+Q3DsELd3ZKaUP9gq+6xm6qOEFSevYaSk5W9i6neChhoA0CGg7mDL9uRwT5iIDfFjZCkL0E+gnHspSM1rd/5BYmzjCYlUPOseUjzO5tBnwv3X+Qx99/BHJCnNpF7woU6a0TnDS6oqubxaMiy67Emn44Qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Gml5pEvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B4C2BBFC;
	Fri, 28 Jun 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gml5pEvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719583878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiBm5EREbGVMfrUkvJrKTbweEBAPn9IDvv8OAj+0kdw=;
	b=Gml5pEvC5ni9IAzAR1oW+Oj+x3zyt15OFmcQ1zGpIqCIlQV2uQF5zWcLXP5llpcdjhzVUv
	LQjbVGfjr/OBSHtFnyfFS8XBDM3NUtbNxH9XudJV/+vl1D1IFFLPttSshM0Du83epmHrBF
	LXRCEHds8p5+NbwoB9rsorvLcSkhXyA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b05e2421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Jun 2024 14:11:18 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25ca169f861so254188fac.1;
        Fri, 28 Jun 2024 07:11:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBp6rysrrQZInySymq3xa0SdrevEYndq0lKYKFHIlNZUfAQnozvuAmDafq//gKNFXbrS87dcOgzPlraaGrghs5GUZd9oAJ7LF+h0Oaz2LAsJHEKhBOYeGZrVbUTmxoIb/t2jafpHAGXVlMzopiBb2p7/DLdhD2+Or4iyBA2jOM9SrHRY0R
X-Gm-Message-State: AOJu0Yy2E0JIyiBP2COEVEKJlUY77ewiU+tTDAphmE3EaFNYyd6jy4ZC
	h3eoxnIgVe8ltGy2gugmViwhd+bdtaH7OAaOm3XytldGPThmbJLdbWKnD5g+y9Ej0776yld8tbI
	Ehq534ad8Ku6+/oLKKuDZT22kWZo=
X-Google-Smtp-Source: AGHT+IH73i4vWkUwP/nwORa1lPm13U0mDbFmM3PEnMtqyVA68Re9x3Dv2/wlZYajXycXMVpAiSG9Efnf12qa3yZKoaM=
X-Received: by 2002:a05:6870:2cf:b0:254:b337:eeb5 with SMTP id
 586e51a60fabf-25d970c8faamr711542fac.18.1719583877248; Fri, 28 Jun 2024
 07:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620005339.1273434-1-Jason@zx2c4.com> <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
 <ZnQeCRjgNXEAQjEo@zx2c4.com> <87v81txjb7.ffs@tglx> <Zn7D_YBC2SXTa_jX@zx2c4.com>
In-Reply-To: <Zn7D_YBC2SXTa_jX@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 28 Jun 2024 16:11:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9pBvKRUnpU1tgRBELRBoPV6m+56Rw9+K+QFsjmzh1fT-w@mail.gmail.com>
Message-ID: <CAHmME9pBvKRUnpU1tgRBELRBoPV6m+56Rw9+K+QFsjmzh1fT-w@mail.gmail.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 4:09=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> perhaps definitely to deal with,

What?! I meant "definitely easier to deal with".

