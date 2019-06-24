Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977B65062C
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfFXJwx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 05:52:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54694 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfFXJwx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 05:52:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so12113506wme.4
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RrWOGQLSuFaCXRqkCQw1GpNc+s0Q4CseKG3Kvw44Shw=;
        b=DCoHB6xY3eLz3XYEk/MV+TWa102/ZzqKZrFVovG3pkCyujl3srGzZ+ARKgTQxPanYW
         HUeKGkI+ZfsdglHWhyFQmJzSvGb/cTYqqGpCEgogSY8hUZ7drOQjiVcEyyOEPCTCP8I2
         vVWUJ096GVTPHP/VDpYYWRZt2bSNoeYfhPpr+KhJksGY8bzzDoZ7S++oEzmTOw3sxaHQ
         lE8K5a0tYztxEOGlLq29IZMaydA2om2Rx5gMp8UV7vLy2gLYop8k4+Kvdjh9CAYoMnXe
         xpV1h6T2RLstvmX3T7OLjfbvzsP5cwmVJH2fQzCEkxvxs1HvLST6xJQWUMJyu6Du+axD
         SIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RrWOGQLSuFaCXRqkCQw1GpNc+s0Q4CseKG3Kvw44Shw=;
        b=p6P3yJRGhh5GXGVukR7iiaPtcH9j8Kqx3dMRt5Gh9x9ROTWkyW7/LJCXAIBgRW3yhb
         5FRcxti97Y/x8u//V1Hqi+F9b5mVE7huJJV36tEWUR+w7qkFaCOQ6x0oMGh2uwaPuVYL
         FiDD3OivquvwCx4ME3bNUKyuruIRGDG+N52wcy1ltgDpKmkMJAPG5Jh8hdMIYwQQphBK
         BBQwJPoruPs312KQtFYhoXW9RE2jdO7UZ3GCI0c3GtmuRsaMDaWKEP86RyXG/RoI1GiC
         Y7eMM0VTNn7jfinwWukW6LbboiLtD9A/nPRpoJ4xkuESpES5FCJS9TyaIHTp3crq2tEQ
         Onvg==
X-Gm-Message-State: APjAAAUwSfH7ptm3qkJPrq1theQqoTlJl5Dcv8c6k22ufzmXoAoVGKcC
        zL0eGT0/X7l0OzQuy/Isj2P2CA==
X-Google-Smtp-Source: APXvYqzcRi9VW5MY/fgFY0K0taW/zNqBWT1EAliuMcqcFZSQEgOrbCOiqiM0C/jd07OKXwZTfhMmNQ==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr15904467wmk.127.1561369971469;
        Mon, 24 Jun 2019 02:52:51 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id w7sm5866229wmc.46.2019.06.24.02.52.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 02:52:51 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:52:50 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190624095250.wtl5t5cewo7scyby@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623113230.GC20697@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190623113230.GC20697@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jun 23, 2019 at 02:32:30PM +0300, Dmitry V. Levin wrote:
> On Sat, Jun 22, 2019 at 12:13:39AM +0200, Christian Brauner wrote:
> [...]
> > Out of curiosity: what makes the new flag different than say
> > CLONE_NEWCGROUP or any new clone flag that got introduced?
> > CLONE_NEWCGROUP too would not be detectable apart from the method I gave
> > you above; same for other clone flags. Why are you so keen on being able
> > to detect this flag when other flags didn't seem to matter that much.
> 
> I wasn't following uapi changes closely enough those days. ;)

(Seriously, you had one job. :) I'm joking of course.)

What you want makes sense to me overall. This way userspace can decide
easier whether to manage a process through a pidfd or needs to fallback
to a pid.

Christian
