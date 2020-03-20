Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3710618D67A
	for <lists+linux-api@lfdr.de>; Fri, 20 Mar 2020 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgCTSCh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Mar 2020 14:02:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33423 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTSCg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Mar 2020 14:02:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id r7so7498726oij.0;
        Fri, 20 Mar 2020 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fvStMn4/m/tx0TBrhCIvKk77L1NDam8pfo0tyLB4w2E=;
        b=C0Q+Ta3uJq5KtxPD7TnvqR83Ltxeegrj/TKyScsQWs39++C2wf9zlos75g7kz8Qlsx
         HluL83r1mJJIegZxw0bwVfOJ0axL/9Z+/aStlZHTc54tZw8QC+oP48iPdJgSdPMf2Lbq
         bpvgumoa8Bku7iDoQk1QJ8E5qq0k4RmRac01Uw4fhbD6Ia+3K0X2Z/GnjwRM388p14jN
         xANG/HPmJyZHEM0wgjYkWPQkBf7yCEA0XZewevAaDu+7MC7ux+9bbMzoyx+tWEehuSTS
         q1vdJpeoY5qtiVA7XdgDFrCubR0quXznbgU6Dq1aKh35apP2f8a/yFsSKuN72EoQMyq5
         u63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fvStMn4/m/tx0TBrhCIvKk77L1NDam8pfo0tyLB4w2E=;
        b=PZciTw7doEZaDnjgQBD1W+jHMPF4DHDaGkP+YJC8NZ9L0usOwqC8zYPOUYXw1RDaCW
         m6eR5yr5jS2zzu3eeSMobfZQtgugvjCjKtVbbBCO7KfwdJqHFexnMAEuEAFw3ryGlKE3
         SrvLe8EfkpDwWmvGlQFJfkrmJaFRzsUZZhbXbpWvt5aUVv6jJQArmCpTn6TE+hTOQx05
         p3AIiuwtF4enmvPQG5VmWBWBmc2AcksbpEPgq4zg7BIFvkU+1GWbQ9AM09j2pSgKw9ME
         M3E12SJ/sg5aA/N7oFZc9SVATnPB/rDMjmoPXdBVFkfGt9alwP9UO41ceXvh6iw5VtjA
         uwHA==
X-Gm-Message-State: ANhLgQ37ZjezKOJSozIh8n12wPOYwiY8xe/GdBpKtrvYXx535Po+q8Qq
        VZLqwYG8tNnbC8nL8fVBK3NZ4/lEijkLtXSUqR2UJsb7+Eo=
X-Google-Smtp-Source: ADFU+vu2P2R8dYjhSjKEhnrTTNhSXnLsFVBxCF98ni5lArt3hVR+gxPQnCkizRPOi/xDqT+/D/ZEgiPUar2RKoalzLk=
X-Received: by 2002:aca:61c1:: with SMTP id v184mr7192269oib.123.1584727355628;
 Fri, 20 Mar 2020 11:02:35 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Fri, 20 Mar 2020 11:02:24 -0700
Message-ID: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
Subject: clock_settime(2) error for non-settable clocks
To:     linux-api@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

If clock_id is a valid clock on the system (i.e. it can be passed to
clock_gettime(2)), clock_settime(clock_id, &ts) sets errno to, either:

  - EINVAL if CONFIG_POSIX_TIMERS is not enabled (kernel/posix-stubs.c);
  - EINVAL if CONFIG_POSIX_TIMERS is enabled (kernel/posix-timers.c)
and the k_clock has no set function (e.g. CLOCK_BOOTTIME);
  - EACCES for dynamic posix clock devices that lack F_WRITE
(kernel/posix-time.c);
  - EOPNOTSUPP for dynamic posix clock devices that have F_WRITE but
don't have a clock_settime op.
  - EOPNOTSUPP for drivers/ptp/ptp_kvm.c (they provide a clock_settime
op that returns -EOPNOTSUPP directly, rather than opt to leave
clock_settime NULL which would do the same thing, see previous point).

The manpage for clock_settime(2) is not very clear:

       EINVAL The clk_id specified is not supported on this system.

       EPERM  clock_settime() does not have permission to set the clock  in=
di=E2=80=90
              cated.

To me, the manpage reads like EPERM should be expected when trying to
set a clock that is not settable.

Should we update the manpage to more fully explain the range of
possible errors or instead try to have more consistent errors? For
syscalls, what's the backward-compatibility contract for errno values?
