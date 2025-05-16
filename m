Return-Path: <linux-api+bounces-3792-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCC8ABA237
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 19:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCA34E35CB
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C292505C5;
	Fri, 16 May 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsEQYNn2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573571F872A
	for <linux-api@vger.kernel.org>; Fri, 16 May 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417901; cv=none; b=WOZLeydoZjgNOAE7sbvMhqGC5xcndRPu2oYMRjf2pi+EpKQRYQYZ+zUj+pZgqWZFkCksXYxVlRQa6eU+R4E9tMr0vVXi7l4J9c2vWMlbQ1WOzCB8eRGG4PdeKqWX05/6FqNCe2Byy9juusG/34ijILgyo8vLHl6oEDTYTypNEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417901; c=relaxed/simple;
	bh=Jy+WmTz6qc9QYY3hsiE44qivMez/2tuInn94qyNI+ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGCiNdc48QgR7BbaNMSCKskU2A2CIdjJSnfNT1lNcZK48KDFshyQcwwY/YQcm0wdq2AndJWfmDwFj0f0uGsMR7nG8oP6kwf5qWzeL0dNd1mrTJ/7o+nJGLQR2cWuTPDDAGpaMg6E63O8li7nzN5vCqSm2jycpa+wCSsupGmNEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsEQYNn2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476b4c9faa2so33605771cf.3
        for <linux-api@vger.kernel.org>; Fri, 16 May 2025 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747417899; x=1748022699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy+WmTz6qc9QYY3hsiE44qivMez/2tuInn94qyNI+ds=;
        b=rsEQYNn2XMSMwCKl2Gh6OctrT1dL/GwabX8qMpb6wxM+iIsoGxzw73c3ZdgWqfGgrl
         aa0sdoHaHEIhTARbf6naOayVfA8O74umwQqhWj7JxS8qrdPXCr+2H//pzC5wdVKdlwN0
         W9JvPr+lW4npqWjDyVR5EOlVaBaQ+GQfS7T/SygmEmWHkgFZ8J0FgGPEEv4dujBeSUEt
         Lc5Ovt+CsHYSv5j7xVNLDrgIaRxPzMbPyt0pCEVNdhmp7o9GW8YW/7a5KSaA+hYR5e0D
         PRv/Rf4FYTp3ltJQqYia/zddjcvONXTIcQIVCOCbWjnB/gQ4daGFS1J8BMJ+hwU8HrOU
         Xi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417899; x=1748022699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy+WmTz6qc9QYY3hsiE44qivMez/2tuInn94qyNI+ds=;
        b=tp3660DPHAQi/DEjG0Qyi+VuhUrqC1krjKqhQUxbqXokzwVaNsFzdoZah+1prCVCKc
         aVlybL7guVZt8Nem4T7bocUZ8amTYFrBkjlX63JIoUdbxTQCRmRyh3/j9TOXe5dMpK2z
         Bk5kS+6RBKLJPeV/eNxGayvT8LNu3NeJqXsNwrrddsbvJzSagWC3EA+SIyPlTMHiZ7+N
         5ADX3EaaoljELLrRZ+lidyvk+M6N9AzE4rgtRU1BVFkWxVzUZSVsw7TDTi8sZuHwpriB
         TtsPm/4/dCIJPqP8KeGejUjktvUOB/6OkkkYWuhQYCHS7JEF6ztP5xXbB6a3oqKsHSjd
         /loQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhRleQVdO6KQKT+osSdg+1aaeahzsAg0q0ENTRFRwlYc7it0DpLjN4uCQohU0tWbiyek+v/cxIuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusU8+OC8ipgbgPopuH+G0etE01TCy2TYjhGKKl/WCwih3z2KB
	S3OVf2wfdnLP5SCuz47wjkv+er/5Vhkmaso2eVLKTsR8Xzk+B038Q60dg5/ld8fZuFpeYLJHqqs
	KAfPme1TxiDNe/HKBjYs6X+153Wx20LMJ5IarZ/k1btDmNPaykzPI4lKb
X-Gm-Gg: ASbGnctXxZFcVyIPpJ3XOA/SjxxldRSQ55SLQd8ikt7XmTE6iwkMQV5GBx4is9cX0nU
	o9gyNEHZTxP/L434fYOAfglij14Wmhyn1d3ruT0TRW8bZduhyO1kK0M9ZyRruSdf/tr6+NKWsar
	ATXOvdhheuf9G0QOOY1ScAj11/l3jXAPDI
X-Google-Smtp-Source: AGHT+IEGXHj/53R5Bv68aQrdKNpvtlL7l0syrd/EcIpro5ctwtrrUE+D3tJuA9fb5VYQstEkki+9oW+YXWtkoedkY2w=
X-Received: by 2002:a05:622a:1f9b:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-494ae391ca0mr75800131cf.17.1747417898964; Fri, 16 May 2025
 10:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747409911.git.jgh@exim.org> <702375d7dcc673fa1f97c92ddf86b47d11106db4.1747409911.git.jgh@exim.org>
In-Reply-To: <702375d7dcc673fa1f97c92ddf86b47d11106db4.1747409911.git.jgh@exim.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 May 2025 10:51:28 -0700
X-Gm-Features: AX0GCFs8OTz6FsXk5jFPCYDvKGtZyHm6IpJhiGhBQcOwFu2TIozizKTNHmLPlKg
Message-ID: <CANn89iLNEnF1YYwOmPsuQn6n-O9N9yVxnZ_djEGxaZ11i4AsVA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tcp: copy write-data from listen socket to accept
 child socket
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 8:56=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> Set the request_sock flag for fastopen earlier, making it available
> to the af_ops SYN-handler function.
>
> In that function copy data from the listen socket write queue into an
> sk_buff, allocating if needed and adding to the write queue of the
> newly-created child socket.
> Set sequence number values depending on the fastopen status.

I do not see any locking. I think you should run a local KASAN/syzbot
instance and you will be shocked.

Honestly we need to be convinced of why adding code in sendmsg() fast
path is worth this.

