Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB5138F61
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAMKlv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 05:41:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMKlv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 05:41:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DAcIXY181014;
        Mon, 13 Jan 2020 10:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=BH0Zfhj/bkhZTgmQat4rcy/rlCpCd+WUpoNWOx3yseI=;
 b=MFVDLxPzCpseFu5RKv+CwjxOfpox51b3K3i4mBvi42i7vEQ6UvG3/6TM8OXQK5TMZyvK
 ZaDmFTt4sdI3L76BW+ig1NAZb/IlY9epbhKJTXz4zBBwISzVxK6WZNTosCV7b+V0GmhC
 OcgsP0GAOFGV0Xb1MM86yC2h51VRGzgrLPnnNKBAettrs5Q44VHbjzzxl52xZD9BX7iq
 TUS/CD4J/648q7xg48KArq5JbnPZZt6PwALaMzZHuGGn0jH4u9OVVbLI6AJk7s/Qi9hi
 XIxpR8J77ohzZalnU6FHp8oLIeMCysaz9nDOi8z8/HiTw6Eg7adaixkYCiXqJ6hetpbx 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74rx4p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:40:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DAbaqs091381;
        Mon, 13 Jan 2020 10:40:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xfrghh3de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:40:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DAe5x4020079;
        Mon, 13 Jan 2020 10:40:05 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 02:40:02 -0800
Date:   Mon, 13 Jan 2020 13:39:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v27 12/12] LRNG - add power-on and runtime self-tests
Message-ID: <20200113103941.GC9488@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2355906.JbblJTOqSk@positron.chronox.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130090
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi "Stephan,

url:    https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-approach-with-full-SP800-90B/20200110-084934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 68faa679b8be1a74e6663c21c3a9d25d32f1c079

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/char/lrng/lrng_selftest.c:117 lrng_pool_lfsr_selftest() warn: sizeof(NUMBER)?
drivers/char/lrng/lrng_selftest.c:229 lrng_hash_df_selftest() warn: sizeof(NUMBER)?

# https://github.com/0day-ci/linux/commit/5b6f2811172c968d8eb78167825c58557ea91995
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5b6f2811172c968d8eb78167825c58557ea91995
vim +117 drivers/char/lrng/lrng_selftest.c

5b6f2811172c96 Stephan Müller 2020-01-09   89  static unsigned int lrng_pool_lfsr_selftest(void)
5b6f2811172c96 Stephan Müller 2020-01-09   90  {
5b6f2811172c96 Stephan Müller 2020-01-09   91  	/*
5b6f2811172c96 Stephan Müller 2020-01-09   92  	 * First, 67th and last entry of entropy pool.
5b6f2811172c96 Stephan Müller 2020-01-09   93  	 *
5b6f2811172c96 Stephan Müller 2020-01-09   94  	 * The 67th entry is picked because this one is the first to receive
5b6f2811172c96 Stephan Müller 2020-01-09   95  	 * an entry. As we start with 1 to inject into the LFSR, the
5b6f2811172c96 Stephan Müller 2020-01-09   96  	 * 67th entry should be equal to rol(1, 7) >> 3 considering that
5b6f2811172c96 Stephan Müller 2020-01-09   97  	 * all other values of the LFSR are zero and the the twist value of 0
5b6f2811172c96 Stephan Müller 2020-01-09   98  	 * is applied.
5b6f2811172c96 Stephan Müller 2020-01-09   99  	 */
5b6f2811172c96 Stephan Müller 2020-01-09  100  	static u32 const lrng_lfsr_selftest_result[][3] = {
5b6f2811172c96 Stephan Müller 2020-01-09  101  		{ 0xf56df24a, 0x00000010, 0x0e014939 },
5b6f2811172c96 Stephan Müller 2020-01-09  102  		{ 0x4b130726, 0x00000010, 0x2802f509 },
5b6f2811172c96 Stephan Müller 2020-01-09  103  		{ 0x87279152, 0x00000010, 0x00150000 },
5b6f2811172c96 Stephan Müller 2020-01-09  104  		{ 0x0b67f997, 0x00000010, 0x00150000 },
5b6f2811172c96 Stephan Müller 2020-01-09  105  		{ 0x4fea174f, 0x00000010, 0xcbf4a6ae },
5b6f2811172c96 Stephan Müller 2020-01-09  106  		{ 0x77149108, 0x00000010, 0x77bfadf2 },
5b6f2811172c96 Stephan Müller 2020-01-09  107  		{ 0x1e96037e, 0x00000010, 0x18017e79 },
5b6f2811172c96 Stephan Müller 2020-01-09  108  		{ 0xc84acef2, 0x00000010, 0x6345f7a8 },
5b6f2811172c96 Stephan Müller 2020-01-09  109  		{ 0x6a2eb6df, 0x00000010, 0x03950000 },
5b6f2811172c96 Stephan Müller 2020-01-09  110  	};
5b6f2811172c96 Stephan Müller 2020-01-09  111  	struct lrng_pool *lrng_pool, *lrng_pool_aligned;
5b6f2811172c96 Stephan Müller 2020-01-09  112  	u32 i, ret = LRNG_SELFTEST_PASSED;
5b6f2811172c96 Stephan Müller 2020-01-09  113  
5b6f2811172c96 Stephan Müller 2020-01-09  114  	BUILD_BUG_ON(ARRAY_SIZE(lrng_lfsr_selftest_result) <
5b6f2811172c96 Stephan Müller 2020-01-09  115  							CONFIG_LRNG_POOL_SIZE);
5b6f2811172c96 Stephan Müller 2020-01-09  116  
5b6f2811172c96 Stephan Müller 2020-01-09 @117  	lrng_pool = kzalloc(sizeof(struct lrng_pool) + sizeof(LRNG_KCAPI_ALIGN),
                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^
Probably just LRNG_KCAPI_ALIGN is intended with no sizeof().

5b6f2811172c96 Stephan Müller 2020-01-09  118  			    GFP_KERNEL);
5b6f2811172c96 Stephan Müller 2020-01-09  119  	if (!lrng_pool)
5b6f2811172c96 Stephan Müller 2020-01-09  120  		return LRNG_SEFLTEST_ERROR_LFSR;
5b6f2811172c96 Stephan Müller 2020-01-09  121  	lrng_pool_aligned = PTR_ALIGN(lrng_pool, sizeof(u32));
5b6f2811172c96 Stephan Müller 2020-01-09  122  
5b6f2811172c96 Stephan Müller 2020-01-09  123  	for (i = 1; i <= LRNG_POOL_SIZE; i++)
5b6f2811172c96 Stephan Müller 2020-01-09  124  		_lrng_pool_lfsr_u32(lrng_pool_aligned, i);
5b6f2811172c96 Stephan Müller 2020-01-09  125  
5b6f2811172c96 Stephan Müller 2020-01-09  126  	if ((atomic_read_u32(&lrng_pool_aligned->pool[0]) !=
5b6f2811172c96 Stephan Müller 2020-01-09  127  	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][0]) ||
5b6f2811172c96 Stephan Müller 2020-01-09  128  	    (atomic_read_u32(&lrng_pool_aligned->pool[67 &
5b6f2811172c96 Stephan Müller 2020-01-09  129  						      (LRNG_POOL_SIZE - 1)]) !=
5b6f2811172c96 Stephan Müller 2020-01-09  130  	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][1]) ||
5b6f2811172c96 Stephan Müller 2020-01-09  131  	    (atomic_read_u32(&lrng_pool_aligned->pool[LRNG_POOL_SIZE - 1]) !=
5b6f2811172c96 Stephan Müller 2020-01-09  132  	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][2])) {
5b6f2811172c96 Stephan Müller 2020-01-09  133  		pr_err("LRNG LFSR self-test FAILED\n");
5b6f2811172c96 Stephan Müller 2020-01-09  134  		ret = LRNG_SEFLTEST_ERROR_LFSR;
5b6f2811172c96 Stephan Müller 2020-01-09  135  	}
5b6f2811172c96 Stephan Müller 2020-01-09  136  
5b6f2811172c96 Stephan Müller 2020-01-09  137  	kfree(lrng_pool);
5b6f2811172c96 Stephan Müller 2020-01-09  138  	return ret;
5b6f2811172c96 Stephan Müller 2020-01-09  139  }
5b6f2811172c96 Stephan Müller 2020-01-09  140  
5b6f2811172c96 Stephan Müller 2020-01-09  141  /*
5b6f2811172c96 Stephan Müller 2020-01-09  142   * The test vectors are generated with the hash_df_testvector_generation tool
5b6f2811172c96 Stephan Müller 2020-01-09  143   * provided as part of the test tool set of the LRNG.
5b6f2811172c96 Stephan Müller 2020-01-09  144   */
5b6f2811172c96 Stephan Müller 2020-01-09  145  static unsigned int lrng_hash_df_selftest(void)
5b6f2811172c96 Stephan Müller 2020-01-09  146  {
5b6f2811172c96 Stephan Müller 2020-01-09  147  	const struct lrng_crypto_cb *crypto_cb = &lrng_cc20_crypto_cb;
5b6f2811172c96 Stephan Müller 2020-01-09  148  
5b6f2811172c96 Stephan Müller 2020-01-09  149  	/*
5b6f2811172c96 Stephan Müller 2020-01-09  150  	 * The size of 45 bytes is chosen arbitrarily. Yet, this size should
5b6f2811172c96 Stephan Müller 2020-01-09  151  	 * ensure that we have at least two hash blocks plus some fraction
5b6f2811172c96 Stephan Müller 2020-01-09  152  	 * of a hash block generated.
5b6f2811172c96 Stephan Müller 2020-01-09  153  	 */
5b6f2811172c96 Stephan Müller 2020-01-09  154  	static u8 const lrng_hash_df_selftest_result[][45] = {
5b6f2811172c96 Stephan Müller 2020-01-09  155  		{
5b6f2811172c96 Stephan Müller 2020-01-09  156  			0x3b, 0xbe, 0x7a, 0xbd, 0x2b, 0x16, 0x02, 0x4c,
5b6f2811172c96 Stephan Müller 2020-01-09  157  			0xfc, 0xd3, 0x02, 0x15, 0xf0, 0x86, 0xd4, 0xdb,
5b6f2811172c96 Stephan Müller 2020-01-09  158  			0x49, 0xec, 0x26, 0x53, 0xd6, 0xc9, 0x6d, 0xad,
5b6f2811172c96 Stephan Müller 2020-01-09  159  			0x24, 0xca, 0x72, 0x89, 0x2c, 0xfa, 0x48, 0x18,
5b6f2811172c96 Stephan Müller 2020-01-09  160  			0xf7, 0x47, 0xb5, 0x2f, 0x92, 0xa2, 0x1b, 0xd9,
5b6f2811172c96 Stephan Müller 2020-01-09  161  			0x24, 0xa7, 0x2f, 0xa2, 0x0b,
5b6f2811172c96 Stephan Müller 2020-01-09  162  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  163  			0xd2, 0xaa, 0xf9, 0x76, 0x26, 0xc6, 0x13, 0xea,
5b6f2811172c96 Stephan Müller 2020-01-09  164  			0xb8, 0xde, 0xe6, 0x88, 0x8f, 0xc4, 0x7a, 0x7d,
5b6f2811172c96 Stephan Müller 2020-01-09  165  			0x9c, 0xb4, 0x1b, 0xd1, 0xd1, 0x8a, 0x40, 0xc9,
5b6f2811172c96 Stephan Müller 2020-01-09  166  			0xaa, 0x45, 0xa6, 0xb6, 0xb5, 0x6f, 0xf6, 0xbc,
5b6f2811172c96 Stephan Müller 2020-01-09  167  			0xbb, 0x77, 0x37, 0xbc, 0x5a, 0x2d, 0xcc, 0x84,
5b6f2811172c96 Stephan Müller 2020-01-09  168  			0x25, 0x68, 0x5e, 0xba, 0x16,
5b6f2811172c96 Stephan Müller 2020-01-09  169  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  170  			0x58, 0x66, 0x82, 0x88, 0x29, 0x19, 0xa4, 0xbb,
5b6f2811172c96 Stephan Müller 2020-01-09  171  			0x33, 0x42, 0xc9, 0x72, 0x0d, 0x68, 0x6e, 0xb9,
5b6f2811172c96 Stephan Müller 2020-01-09  172  			0xc6, 0xe0, 0x7a, 0xf9, 0x20, 0xca, 0x6d, 0x18,
5b6f2811172c96 Stephan Müller 2020-01-09  173  			0x35, 0xec, 0xfa, 0x9e, 0xf6, 0x3a, 0xa7, 0xb6,
5b6f2811172c96 Stephan Müller 2020-01-09  174  			0x92, 0x7a, 0xe5, 0xcd, 0xc5, 0x13, 0x9f, 0x65,
5b6f2811172c96 Stephan Müller 2020-01-09  175  			0x6a, 0xe1, 0xe4, 0x3f, 0xb9,
5b6f2811172c96 Stephan Müller 2020-01-09  176  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  177  			0xdd, 0xf1, 0x34, 0xca, 0x08, 0xe3, 0xce, 0x8a,
5b6f2811172c96 Stephan Müller 2020-01-09  178  			0x26, 0x6b, 0xce, 0x99, 0x8a, 0x84, 0xd2, 0x21,
5b6f2811172c96 Stephan Müller 2020-01-09  179  			0x98, 0x10, 0x95, 0x5f, 0x9f, 0xc3, 0xf2, 0xe4,
5b6f2811172c96 Stephan Müller 2020-01-09  180  			0x79, 0x75, 0xb5, 0x15, 0xa7, 0xa2, 0xf1, 0xc4,
5b6f2811172c96 Stephan Müller 2020-01-09  181  			0xdc, 0x67, 0xcb, 0x67, 0x8c, 0xb2, 0x1b, 0xd5,
5b6f2811172c96 Stephan Müller 2020-01-09  182  			0xd6, 0x8b, 0xc2, 0x34, 0xd6,
5b6f2811172c96 Stephan Müller 2020-01-09  183  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  184  			0xc3, 0x16, 0x9d, 0xf0, 0x78, 0x15, 0xab, 0xf2,
5b6f2811172c96 Stephan Müller 2020-01-09  185  			0x2f, 0xc9, 0x2e, 0xe1, 0xc6, 0x5e, 0xfa, 0x03,
5b6f2811172c96 Stephan Müller 2020-01-09  186  			0xaf, 0xd4, 0xd5, 0x47, 0x2a, 0xe8, 0x06, 0xe8,
5b6f2811172c96 Stephan Müller 2020-01-09  187  			0x7e, 0x0a, 0x71, 0xc7, 0x0d, 0x39, 0xb1, 0xa9,
5b6f2811172c96 Stephan Müller 2020-01-09  188  			0x5a, 0x49, 0xee, 0x8b, 0x2f, 0xcd, 0xea, 0x96,
5b6f2811172c96 Stephan Müller 2020-01-09  189  			0xcc, 0x08, 0x71, 0xef, 0x9c,
5b6f2811172c96 Stephan Müller 2020-01-09  190  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  191  			0x1a, 0x3d, 0x70, 0x39, 0xc2, 0x02, 0x4d, 0x3a,
5b6f2811172c96 Stephan Müller 2020-01-09  192  			0xaa, 0x14, 0x20, 0x88, 0x96, 0x4c, 0x7c, 0xe4,
5b6f2811172c96 Stephan Müller 2020-01-09  193  			0xaa, 0x49, 0x89, 0x30, 0x50, 0x96, 0xb6, 0xa7,
5b6f2811172c96 Stephan Müller 2020-01-09  194  			0x55, 0x0a, 0xf8, 0xd2, 0x4e, 0x83, 0x9d, 0x1f,
5b6f2811172c96 Stephan Müller 2020-01-09  195  			0x56, 0x49, 0x13, 0xc6, 0x46, 0x55, 0x73, 0x0d,
5b6f2811172c96 Stephan Müller 2020-01-09  196  			0x74, 0xcd, 0x81, 0xe0, 0x65,
5b6f2811172c96 Stephan Müller 2020-01-09  197  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  198  			0x4b, 0xf6, 0x49, 0x89, 0x2a, 0x9f, 0x67, 0xd7,
5b6f2811172c96 Stephan Müller 2020-01-09  199  			0xb8, 0x1d, 0xbb, 0x5d, 0xf0, 0x1b, 0x60, 0xb6,
5b6f2811172c96 Stephan Müller 2020-01-09  200  			0xb7, 0xf3, 0x86, 0x6d, 0xe0, 0x04, 0xa1, 0xbc,
5b6f2811172c96 Stephan Müller 2020-01-09  201  			0x3b, 0xb0, 0x10, 0x91, 0xe8, 0x22, 0x67, 0x5b,
5b6f2811172c96 Stephan Müller 2020-01-09  202  			0xe8, 0xf0, 0x4f, 0x82, 0x70, 0xc7, 0xe1, 0xc8,
5b6f2811172c96 Stephan Müller 2020-01-09  203  			0xd8, 0xad, 0x70, 0xcf, 0xf6,
5b6f2811172c96 Stephan Müller 2020-01-09  204  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  205  			0x60, 0x1f, 0x71, 0x07, 0x92, 0xae, 0xa0, 0x24,
5b6f2811172c96 Stephan Müller 2020-01-09  206  			0xb6, 0xa4, 0x10, 0x70, 0x1f, 0x94, 0x51, 0x9a,
5b6f2811172c96 Stephan Müller 2020-01-09  207  			0x5a, 0x81, 0xc4, 0x46, 0x78, 0x56, 0x71, 0xdd,
5b6f2811172c96 Stephan Müller 2020-01-09  208  			0x45, 0x63, 0x01, 0x34, 0x87, 0x79, 0xb4, 0xd5,
5b6f2811172c96 Stephan Müller 2020-01-09  209  			0x91, 0x79, 0xb9, 0x93, 0x11, 0x44, 0x50, 0xad,
5b6f2811172c96 Stephan Müller 2020-01-09  210  			0x64, 0x7e, 0x5c, 0xec, 0x16,
5b6f2811172c96 Stephan Müller 2020-01-09  211  		}, {
5b6f2811172c96 Stephan Müller 2020-01-09  212  			0x49, 0x2f, 0xa0, 0x45, 0xf8, 0xb0, 0x80, 0x88,
5b6f2811172c96 Stephan Müller 2020-01-09  213  			0x79, 0xeb, 0xb6, 0x82, 0x1c, 0xf3, 0x67, 0xc4,
5b6f2811172c96 Stephan Müller 2020-01-09  214  			0x88, 0x88, 0xe9, 0x75, 0x20, 0x54, 0x78, 0xc6,
5b6f2811172c96 Stephan Müller 2020-01-09  215  			0x5c, 0x59, 0xcf, 0xd9, 0x73, 0x12, 0x17, 0xf4,
5b6f2811172c96 Stephan Müller 2020-01-09  216  			0x30, 0x9c, 0xb7, 0x21, 0x45, 0xe2, 0xb6, 0x0c,
5b6f2811172c96 Stephan Müller 2020-01-09  217  			0x0c, 0xeb, 0x1b, 0xdc, 0xdc,
5b6f2811172c96 Stephan Müller 2020-01-09  218  		}
5b6f2811172c96 Stephan Müller 2020-01-09  219  	};
5b6f2811172c96 Stephan Müller 2020-01-09  220  	struct lrng_pool *lrng_pool, *lrng_pool_aligned;
5b6f2811172c96 Stephan Müller 2020-01-09  221  	u8 hash_df[sizeof(lrng_hash_df_selftest_result[0])]
5b6f2811172c96 Stephan Müller 2020-01-09  222  							__aligned(sizeof(u32));
5b6f2811172c96 Stephan Müller 2020-01-09  223  	u32 generated;
5b6f2811172c96 Stephan Müller 2020-01-09  224  	int ret = 0;
5b6f2811172c96 Stephan Müller 2020-01-09  225  
5b6f2811172c96 Stephan Müller 2020-01-09  226  	BUILD_BUG_ON(ARRAY_SIZE(lrng_hash_df_selftest_result) <
5b6f2811172c96 Stephan Müller 2020-01-09  227  							CONFIG_LRNG_POOL_SIZE);
5b6f2811172c96 Stephan Müller 2020-01-09  228  
5b6f2811172c96 Stephan Müller 2020-01-09 @229  	lrng_pool = kzalloc(sizeof(struct lrng_pool) + sizeof(LRNG_KCAPI_ALIGN),
                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^
Here too.


5b6f2811172c96 Stephan Müller 2020-01-09  230  			    GFP_KERNEL);
5b6f2811172c96 Stephan Müller 2020-01-09  231  	if (!lrng_pool)
5b6f2811172c96 Stephan Müller 2020-01-09  232  		return LRNG_SEFLTEST_ERROR_HASHDF;
5b6f2811172c96 Stephan Müller 2020-01-09  233  	lrng_pool_aligned = PTR_ALIGN(lrng_pool, sizeof(u32));
5b6f2811172c96 Stephan Müller 2020-01-09  234  
5b6f2811172c96 Stephan Müller 2020-01-09  235  	generated = __lrng_pool_hash_df(crypto_cb, NULL, lrng_pool_aligned,
5b6f2811172c96 Stephan Müller 2020-01-09  236  					hash_df, sizeof(hash_df) << 3);
5b6f2811172c96 Stephan Müller 2020-01-09  237  
5b6f2811172c96 Stephan Müller 2020-01-09  238  	if ((generated >> 3) != sizeof(hash_df) ||
5b6f2811172c96 Stephan Müller 2020-01-09  239  	    memcmp(hash_df, lrng_hash_df_selftest_result[CONFIG_LRNG_POOL_SIZE],
5b6f2811172c96 Stephan Müller 2020-01-09  240  		   sizeof(hash_df))) {
5b6f2811172c96 Stephan Müller 2020-01-09  241  		pr_err("LRNG Hash DF self-test FAILED\n");
5b6f2811172c96 Stephan Müller 2020-01-09  242  		ret = LRNG_SEFLTEST_ERROR_HASHDF;
5b6f2811172c96 Stephan Müller 2020-01-09  243  	}
5b6f2811172c96 Stephan Müller 2020-01-09  244  
5b6f2811172c96 Stephan Müller 2020-01-09  245  	kfree(lrng_pool);
5b6f2811172c96 Stephan Müller 2020-01-09  246  	return ret;
5b6f2811172c96 Stephan Müller 2020-01-09  247  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
