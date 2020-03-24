Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAAAE19098D
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCXJaM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 05:30:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37255 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCXJaM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 05:30:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so16383810otp.4
        for <linux-api@vger.kernel.org>; Tue, 24 Mar 2020 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
        b=dT+SeYyH1BkKkZWUaBk5uj0MEH4L6HjmlSYG1+nPnGCG3gAENzp0qjsWHAigkjMhtR
         ljAI1uUGzbpci1deREeZbmrQws6bf2gHk+9gusG81aJYoCIN4nyvPaaP6ug29PD+78AD
         pBmUMig88uOYaX5iSgRyVzEwUEzyGAd5Yu8cNqY1KACcX65WNHrT7gMMS3T4RjMXKiRj
         9kQwaauv82/bqrFcDf7AtzgFGJe0b9boON8gM98zVPL6FMxsx9RRo+vJqhikkynkr4WI
         +/oWFfjdmud6SHbfCHGyb5rghdGaq7+cR5SuHhjkz0L5/L+PbiIqnNVLVHCPGSKi0cpY
         kOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
        b=AWZDdXUGXPCT8ZDXRfpj34SZ05hwJeJgXsW7r1YJTL/Hrk+RcqSHsjx+4xLFH0HVt2
         iwBygg2MxF+ayx0z/gQ82X9SWiBN0LYdlK9AshNhHU4hTsDdm56U2/L5eQ8j+HnEPmcT
         TseLo0cHWS1yd6UWrW9fS8NqUYiLlijMO5Lpr1Qxjq1NBHzaO5rilxNPK8//LoCbtJc6
         5JrCqzP2xjM3KO+ukG+Kit7Fv2lNV28IWEsPqZWRv0sQn8DIpDneOoLFK1S1HhLNjZv3
         HOi3w/kwoTvGT7G9hs4zV8tIFEyCTlxfF6EPMebxwZVaL1N6WZR2MChXFFMawgc4ZEQ5
         IESQ==
X-Gm-Message-State: ANhLgQ3fNkfPhV/2RTi2bNMgCzN2HIwDPe79R3+fyouklseFqB/47yd2
        3FePTEYX+phUEE1R4kwbE7VBxDmJ1DEGCT88F2B8bw==
X-Google-Smtp-Source: ADFU+vsVpjNMAvc6231UF5jnLInFznAbjT7PjgwTqzNrcYLn3q1rK1MSp0eBo3cutIGiQ6yNzxYDBwJUhUQYQLc0WIo=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr1673767oor.63.1585042209973;
 Tue, 24 Mar 2020 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
 <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com> <20200324023431.GD53396@mit.edu>
In-Reply-To: <20200324023431.GD53396@mit.edu>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 24 Mar 2020 09:29:58 +0000
Message-ID: <CAFEAcA_6RY1XFVNJCo5=tTkv2GQpXZRqh_Zz4dYadq-8MJZgTQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 24 Mar 2020 at 02:34, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> Another possibility, which would be messier for qemu, would be use a
> flag set via fcntl.  That would require qemu from noticing when the
> guest is calling open, openat, or openat2, and then inserting a fcntl
> system call to set the 32-bit readdir mode.  That's cleaner from the
> kernel interface complexity perspective, but it's messier for qemu.

On the contrary, that would be a much better interface for QEMU.
We always know when we're doing an open-syscall on behalf
of the guest, and it would be trivial to make the fcntl() call then.
That would ensure that we don't accidentally get the
'32-bit semantics' on file descriptors QEMU opens for its own
purposes, and wouldn't leave us open to the risk in future that
setting the PER_LINUX32 flag for all of QEMU causes
unexpected extra behaviour in future kernels that would be correct
for the guest binary but wrong/broken for QEMU's own internals.

thanks
-- PMM
