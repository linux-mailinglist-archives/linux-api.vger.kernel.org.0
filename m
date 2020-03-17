Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6900D188465
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQMiZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Mar 2020 08:38:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45696 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQMiZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Mar 2020 08:38:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id x143so814143lff.12
        for <linux-api@vger.kernel.org>; Tue, 17 Mar 2020 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=hnj4sEry8e72e+4XxcViMh2kR/clVi9rs+0bXE1Bk+1jnM9tAaTyTvgL4uYk9HGokQ
         CS6JmX/z0c6hGZP4+/nsjdwrRToHL2MnmrEP2s5tbTN6meK7gab1DE86o95g8btZIabJ
         X0Nb39RB/DJ0JWjBmqOkl9uU6GNs9+S6/0dZvKl3+nAxc/hPOac2EFucKTzFdRe8iZbM
         pd2Cz/K1I/XtSdYirkd2zkc5FVQnbLpfFYWuWeR4JcwrggK69xvkfXK7qVwpyd+zrveT
         XkUuyowMJlxJdZtfXDBqIGaPNwQ4N/hPoHdbjT/raGV9/FQs/kLHLi9N8GnTZjdSG/jt
         rWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=azdbWXc9LFnxTj8YVs/Xf8KHyAREuQvB/Xa61/SaydrYcPQBzJ60RxACufPG/uHQTp
         GOF5V0/ZqUyQoGG+y+CCVR8VOcSWFStaSm+y0kLEE+7rBizCkfeuhH1rZx1mKEXAjHUt
         qPdMjBHFKFw/Q+Xr5dPzGgBwDoxB1EpdVyV3M4AQ33lwyKrWcGCmy64hC6zLvUMGqpN7
         IFCekDunfXyvUM1sAseCYjmi6wAuTkGn8EOCjQH5CwzD4bl2yhJeOa/eyX1e1WOMSP0C
         c5Pf5bdN9CSjfVUz5AiSdoh+sv5YtcjLLMDd4ey3qz/q4/wSXkoOZvUxRk5UcrQuSu/p
         CKhA==
X-Gm-Message-State: ANhLgQ3VU30SfgIL/T8L3MjSTIJoG3cs9pm741Bh0LfIw4M934oP17Gz
        3vyV1SjIyJ5+4bV7ufzNk44ugEdJt/i7qeRYNDn9K6D46zY=
X-Google-Smtp-Source: ADFU+vtpPO/SB7g4ehk7qTFyPKse2g7Gmfi77CZPwCuVUbJVQI6d70Lf5FyUoeDifSP8iaSTW1v77WW+rDocRRRH0SY=
X-Received: by 2002:a19:6502:: with SMTP id z2mr2694078lfb.47.1584448702419;
 Tue, 17 Mar 2020 05:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org> <87lfnzdwrf.fsf@mid.deneb.enyo.de>
In-Reply-To: <87lfnzdwrf.fsf@mid.deneb.enyo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Mar 2020 13:38:11 +0100
Message-ID: <CACRpkdY8uLVrT5=NMpNmKhgmqu=yT_Bgc-Q9-BR6NgRFjnzjFQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 17, 2020 at 12:53 PM Florian Weimer <fw@deneb.enyo.de> wrote:

> Just be sure: Is it possible to move the PER_LINUX32 setting into QEMU?
> (I see why not.)

I set it in the program explicitly, but what actually happens when
I run it is that the binfmt handler invokes qemu-user so certainly
that program can set the flag, any process can.

Yours,
Linus Walleij
