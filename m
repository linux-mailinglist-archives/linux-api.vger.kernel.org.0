Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021AF6DD47A
	for <lists+linux-api@lfdr.de>; Tue, 11 Apr 2023 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKHmO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Apr 2023 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDKHmN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Apr 2023 03:42:13 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 00:42:08 PDT
Received: from mail.bizcodes.pl (mail.bizcodes.pl [151.80.57.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D81986
        for <linux-api@vger.kernel.org>; Tue, 11 Apr 2023 00:42:08 -0700 (PDT)
Received: by mail.bizcodes.pl (Postfix, from userid 1002)
        id BB69FA38C7; Tue, 11 Apr 2023 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizcodes.pl; s=mail;
        t=1681198332; bh=5QPMt7jNntM5ZbstM20BWsHIeLbmRE8lVU4Iu89IleQ=;
        h=Date:From:To:Subject:From;
        b=FgbtYjdSepcoGkp3EP5/ST1a4SmqabSNj+wNojHJwONDYtRocYXNe7swv2CsT6wxa
         VITHxUV8QRAf1Y7qf9HTFvO0ZhmUYbw21aWaGjtywfv4qqBBHAf76O4zDuEkrShYSf
         eXPc0m3sACSHv4vGJWcSFxSCwmaIpXTAtwNSlrPA8pNGQ3EnK4P5ubffDrv999crCN
         wxiwPeEjS3hf5HiUjIsDAP5FoT/T2k3pcAG6TEcun9odeZm+r7bk/UkcnWuvVcLv0o
         Ut4xFhz2z/97VdeaJTnyl0juFuOL0JHrnVJv58g0tyBwdcmbfsuzOFg3ev1j0Rf5YB
         bbVFbjP2EuKBQ==
Received: by mail.bizcodes.pl for <linux-api@vger.kernel.org>; Tue, 11 Apr 2023 07:30:23 GMT
Message-ID: <20230411064501-0.1.8l.pakh.0.i6d66p62mf@bizcodes.pl>
Date:   Tue, 11 Apr 2023 07:30:23 GMT
From:   "Marcin Chruszcz" <marcin.chruszcz@bizcodes.pl>
To:     <linux-api@vger.kernel.org>
Subject: Prezentacja
X-Mailer: mail.bizcodes.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: bizcodes.pl]
        *  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [151.80.57.56 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: bizcodes.pl]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe tworzenie planu tras czy =
dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Marcin Chruszcz
