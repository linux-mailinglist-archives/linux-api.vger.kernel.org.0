Return-Path: <linux-api+bounces-2249-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AD95F14A
	for <lists+linux-api@lfdr.de>; Mon, 26 Aug 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546B71C21E8D
	for <lists+linux-api@lfdr.de>; Mon, 26 Aug 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117316F0EB;
	Mon, 26 Aug 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O5dxkop4"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609516E886
	for <linux-api@vger.kernel.org>; Mon, 26 Aug 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675181; cv=none; b=QI6PJ07LNEwxDZvfGz+ENsTX8nmC4gY7D2qAfa6PzeoPpsZtB7C+nQDEnBIBztqdJAwjBLYgsxk094V0vmMdDseo0a2IMEmpn0VNRnawr1PeA+r/4F1o90+PJPY9cRpQrfZm8IS/08XZw+fb+3+2EDob+pLZLNTGwRgs2iNxDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675181; c=relaxed/simple;
	bh=pagydAvzvZpx88GqbX7fQb/9e8ooMGjJGmoNcsY+0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXSUbwE4CeSE3xlvodC8BbDaY5XCnbRhGQxJ9aSzuRnFjJ7RSbazTl35QZ3W3kjEzXlGwijz4Wc42QqFpMTkn4rQ+8uHX9CQA4ChDs2rqKYAMHCi8VNo4TIxsu1Hbfg0FV0HTGo+GypehEahRPqNJ3YEKLN8cT7vvvNyHwWItKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O5dxkop4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343eeb4973so3304599e87.2
        for <linux-api@vger.kernel.org>; Mon, 26 Aug 2024 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724675177; x=1725279977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=O5dxkop46IFyT1R9BcvU3+t2qWZFZXPCvMLc28Jo/ji4JbdZAYCeERNEpNWPA3j2Or
         qfV9kkFGeEU4FOF0cMe28Tg1gM7leZtrKJh7DIlgC9dA5mUfqca3dLBhtwzq5FqJHe2y
         4+LaQq3yEwsn5iEVcLYekkhczHfyNrWJ0cdFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675177; x=1725279977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=oVatA+weii/nM7Q5TfZ1t3XnuuUhPbEcOmaItTt3BYYooUf6RvLkID6y4sjIo7b3Fa
         ToNt1sr0A6OQPlrfiT6Io4Bu169yANcgTOC+43sF9Mo8PaXjhp3y8Vceu7/ZFej/49+e
         6pmSLeQYBEFsD8inl1zJYbVf/pwF2K1bNQU/St7A8+zcii3mJHNhgFUKNiPurVWun/05
         f5sY3XEMl7pzbrXolRc4i4BiH0SK/LG0TkwIC+T7s1kVI+HFHKJk7ChtcmlJ20QonmfV
         MTPlKyXwoQ8tTW4Ipdk1xFlZGSszvPILYDVxXFcEVIyrUdZtdmuxBTdXdA+YD/p1FcHy
         tOFg==
X-Forwarded-Encrypted: i=1; AJvYcCVPoqSNEabL9qrTukfKh2Jdj0ip2y2UiwGhtiqSjZXpZMj8m6Rd2f/dLlr3jSBbnFd0DjRt0/C2Y5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwofiUKUHjZlqnV8wuGzhUIctDTMqK3/R5iFkSYBHxgyW/mxLSX
	9y/AfbrjDmMBZWQlVu2HRKVd32UYfx8B5XCCIHQxbSJ+zh+Hu3RmBd9UsNfq9XBUdJegOnRrpzF
	kTmaIqq+XfbcsWALHBcGlD4Bk/7paHdrTGGVBNA==
X-Google-Smtp-Source: AGHT+IHcIrvI4/qCTVNkp4GR0C2hU9chlKv5LmalO9VjJeNbl8gIATqDEuVCEuFUip3z+LI8mm4ypP9hikrdoWLQ0Zg=
X-Received: by 2002:a05:6512:ba1:b0:52f:cd03:a823 with SMTP id
 2adb3069b0e04-5343887e0f9mr9418735e87.45.1724675176318; Mon, 26 Aug 2024
 05:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87seurv5hb.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87seurv5hb.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 14:26:04 +0200
Message-ID: <CAJfpegsxVmJLT7uL7d2s1nhGQaXr4ymYeZZ-ttaOAVauf6Zv=w@mail.gmail.com>
Subject: Re: Recommended version handshake for FUSE clients
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 14:22, Florian Weimer <fweimer@redhat.com> wrote:

> Or perhaps I should bundle some older version of <linux/fuse.h> with my
> sources?

Bundling the fuse header with your sources is the only sane thing to
do.  Libfuse does this, and so should you.

Thanks,
Miklos

