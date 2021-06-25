Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881F3B42FC
	for <lists+linux-api@lfdr.de>; Fri, 25 Jun 2021 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFYMRW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Jun 2021 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFYMRW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Jun 2021 08:17:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E83C061574
        for <linux-api@vger.kernel.org>; Fri, 25 Jun 2021 05:15:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so7850044pjy.3
        for <linux-api@vger.kernel.org>; Fri, 25 Jun 2021 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qptnMvJRz0EaWNdV9qTCxcaQkezfanoot9Riive9Tjk=;
        b=egx+herDKAMYKmUg+Qzt1hZaCzZVHFzXMJg+2heHz+FNx9EWMkEY7yY2FFjMI1dyJz
         bNCPpqbow6X8lijemsmWk7QSLeVhCcs+z1qsSC8Xg/LvSGtNLniTFzvtox3+kf1Z+JNu
         B+5eWWGdfx3C4NQqDUqpOmJQ6yEQsdT/GdvyizO1eWPQpH3bifxl1i/0uabdGrG+PJSJ
         TaOS9ihKF89iR8TvWmStRBLgB1sCHze5QfhjV3C/tLIQVOZNfMRWMbN34AEeIXUsZhir
         OEpz1r9aogqJ94MyJ4OmyJkWze2csUDytFRmHzC19msnQartDL1oVzSIc4Kw9qgD8O9b
         MlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qptnMvJRz0EaWNdV9qTCxcaQkezfanoot9Riive9Tjk=;
        b=WvJ49iNOThplyk77bH05yRGhE7Oc9JhruATdWTxGt+i4gz61zc3l5iXayNhkXPQa3A
         efC85tjdpA59tIUrn+H4ruXX+U+Nz0H+5SAk4T1fvP+HTpnCk/SkqQ/H4sSY3YfFjx5u
         AoQx/qIyfeGBLByrdl3IrhK5E4Fgs3EEnzPhanNKvoj0G1CoT1So79nPGE/UsrhsbtPL
         1LJvNhnRGym2diU3qnnYHtktxgVsHsjfoH4okb6ep7F41/0ikij4gHxuf3n7Qh1va06h
         KjKgp4G7/FLfW+pV6+uyQpImNI7hrqlUG5/cfJqSLh7ODgoB9V6JdfndIvxsFckesEzj
         jdDw==
X-Gm-Message-State: AOAM530Mbgf2/L4BPh8oMznuGhvk658FiqifH8IgcvhViT44oHdPJ6Fz
        mreMBPW34yY314Vcyg7EwrrY62Y3zeaDR8tAuwY=
X-Google-Smtp-Source: ABdhPJyo4ta6f8bXRTvCSuZxd9Ft+mFg6C9HNwULn4XHt76k/KTkPqsrUXTdp+rMo+jgBmTAN3VMddFYbIX2Fgd+H5U=
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr21238142pjd.39.1624623300343;
 Fri, 25 Jun 2021 05:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net> <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
In-Reply-To: <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Fri, 25 Jun 2021 14:14:49 +0200
Message-ID: <CAK1hOcP0J2hxJ=s1xpBjp4RqOWHruhcL4WUN80qsTkM-idc3AQ@mail.gmail.com>
Subject: Re: lsattr: incorrect size for ioctl result
To:     Rob Landley <rob@landley.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 25, 2021 at 10:44 AM Rob Landley <rob@landley.net> wrote:
> Which raises the question "why is there an IOC32 version of this when it was
> never NOT 32 bit" and "does GETFLAGS have the same problem"? (Haven't looked...)

Yes, GET/SETFLAGS also read and store int-sized value.
