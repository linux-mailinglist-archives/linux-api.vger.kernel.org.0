Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183F319CAFB
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbgDBUT7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:19:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46141 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbgDBUT7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:19:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id cf14so6052185edb.13;
        Thu, 02 Apr 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=uZ0tLfqliz8q4xJM/VE+emq9M+ya9pU6I1gn/JALrxk=;
        b=IXUE7gRc/Gu2khfuy746HpBB17H9+J8ig6zqRZxTmF8SFevNGxvgLnx1L3CnGc3dVv
         zeVj1dI4iBhhMlrTuqbqEzV3yn8dgKq/cWA3ZvUnfSI8+1gXQ9NbESC/a4nMutjDbbJO
         SFNjlZlBRXEil8bN4TvTvc/uUWul8d1SjIwthRkUNzJjxDx/Rs0Y5oepexocLwU7YWV0
         nJILyLEosen8wp3x7/yV5iIaOQZP0CvbU4btIE8jope0qWMsbEblNUNblz1cycBtHy2L
         3weugb1tgC50YaM12nv7flZuuFTEAJPYIP3aFBg2+9OsRE1uzG7b8exE4ZCOwFMgDHq6
         JCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=uZ0tLfqliz8q4xJM/VE+emq9M+ya9pU6I1gn/JALrxk=;
        b=sRg1PZ7++FkSVSOZoGjq6zl2ZB1ZB7oeE2o5TCnH/5tKwmXB0F8hZn6n4pU+lE8FEi
         kjWsXO6gXsVAUrlYHlTkp0ftcEi13CsQLEKxkvrRw99NaLShrwKgaMN3dhV8TxeYs329
         n/yAVL7DRL0FqoYNeO2IByE6bkoLKEHitxJCb5ouGgXVJjE5wiYhD43C0eUXl+pdIDTg
         TLYsluC+zTZ8ejEsJzMPFqCJAnBuoNLvW0TDI22uNM911mbo+0SCBtwYP6gQ1zuxpOWt
         CcT2yG+sya8TZrOkEOSSkyYKsbc1fDtar1aoaj1ryyClRdB78ighvldLDrgowmBqf4EG
         RC/A==
X-Gm-Message-State: AGi0PuYiRtYBUKvyRTLJVeebObjAPIwHbFL6jGrWBZ84ZaGO20Xeyhjy
        WRZV+garMTkdFthrqn3iNkLxfy29GiL6tPwAeLMxnUBM
X-Google-Smtp-Source: APiQypINaXU08pfg0ihORFYqR45XkjVEnUlhI3vhCzuMlZom8I/JjLIgH2+y1KnuftrXSEggiP9CJ1rzWlF/T+eTBxc=
X-Received: by 2002:a05:6402:1485:: with SMTP id e5mr4811503edv.239.1585858797065;
 Thu, 02 Apr 2020 13:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com> <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
In-Reply-To: <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 2 Apr 2020 22:19:45 +0200
Message-ID: <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello =C3=89ric,

On Thu, 2 Apr 2020 at 22:07, Eric Rannaud <eric.rannaud@gmail.com> wrote:
>
> Micheal,
>
> I'm conscious that saying "dynamic POSIX clock device" without any
> explanation may be too obscure for a man page.

It's true that more detail would be nice, but...

> There is documentation in:
> - include/linux/posix-clock.h
> - Documentation/driver-api/ptp.rst (explicitly states that EOPNOTSUPP
> should be returned)

(Is this a reference to the tack that I tweaked your patch to change
EOPNOTSUPP to ENOTSUP?)

> - include/uapi/linux/ptp_clock.h

... it's a bit of a stretch to call any of those documentation, since
they don't really describe the concept of a dynamic POSIX clock
device.

>
> (IEEE 1588 PTP is the canonical user of these dynamic clock devices)
>
> Would you want to refer to any of these from the man page?

See above. I would be happy to add a 2 or 3 sentence note to the page
that briefly describes the concept of a POSIX clock. Would you be able
to come up with something?

> Thanks for maintaining this project!

Thanks. Though it has suffered a lot of neglect of late :-(.

Cheers,

Michael
