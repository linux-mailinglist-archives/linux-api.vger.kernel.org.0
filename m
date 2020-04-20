Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D321B1015
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDTP3p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTP3o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Apr 2020 11:29:44 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB34C061A10
        for <linux-api@vger.kernel.org>; Mon, 20 Apr 2020 08:29:44 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q204so9065157oia.13
        for <linux-api@vger.kernel.org>; Mon, 20 Apr 2020 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
        b=ah1shf4HSg/nvJ8s11qa+8NLytbbP2+0zc73p3ql5uknLz2DKkaIN1AMLSCXwCoQOB
         IUUNGwz+DoPmYxblBA9qILxBrLosv/D5rtRuJKby1Q4gjKAmckfomvUUsaxvzuo6jCH7
         aqihy/dQmta8H50f6yKPqN3XUmS/+txHciVu9yA68j+iORY3e1prjo7HcQUuAGQuPNiY
         PGTV2YlVJsylE2iPM1M8tfX9pefTk9qQqdQ487KHyPq8P4aNDCrnsRG15PRdri0HFVwW
         ZE0FWBNlj7vf1iMsuc68NqPtwGh0j3Lhp1LaYo9d+oCYclxukpkYlCbsI9dAVjkynYI2
         77SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
        b=FjR7kHgzy8fqd7Svxchnh8qr9SkikWqxcQ5CL6tkYt+xRNFqibe3ZJ1x+1sa8ljwkl
         GVaNpg3lzXPQtZq5wrCCZSAoiCybek/o2uRejfadol3NMfN3uqQasbaleRcVaPEHX1HQ
         KrJn8P1ISKbdLuP6qCF5RJr3+Ykqn2D/q5ZbrsIvjI76sKcHeodLJI6z1HUypzK9E34F
         33O9Bdx9l3pyeLGMlp0n6Exj1yZO4I8tZfUFr0EG1dGk/MigQx2q0Uq+aEwmdJiM6Cku
         MaRodzs2L6gDv3KujYBMurwXrrBDteTYUV6lcjdzj0w8KXxmYm9PNE4QZKTAN0UK0wUw
         sABA==
X-Gm-Message-State: AGi0Pub2hV7FkrQoRjjJJH1guZ8WbNcOH15MIGnPH2W4Hm5oTVVsSWHH
        3/wiRYz/GwB/RpipND1vv/bC9TQFvlwHWrMNivD6rg==
X-Google-Smtp-Source: APiQypJiq2K2V4ldr/J8WQcI/YqsUZiz1LKQorCqjmJgGRBjKTVuRpqVwN+xWRf8OGxvvJhbxblTyskx5LHJFx1jgWY=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr10490068oia.146.1587396583373;
 Mon, 20 Apr 2020 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu> <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
In-Reply-To: <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Apr 2020 16:29:32 +0100
Message-ID: <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Eric Blake <eblake@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 20 Apr 2020 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> It will be interesting to find how much code (wrongly) assumes it can
> use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally
> wipes out other existing flags, when it should have instead been doing a
> read-modify-write to protect flags other than FD_CLOEXEC.

For instance, a quick grep shows 4 instances of this in QEMU :-)

thanks
-- PMM
